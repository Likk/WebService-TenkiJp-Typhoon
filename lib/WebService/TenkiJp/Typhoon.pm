package WebService::TenkiJp::Typhoon;

=head1 NAME

WebService::TenkiJp::Typhoon - Tenki.jp Typhoon Weather NEWS client for Perl.

=head1 SYNOPSIS

  use WebService::TenkiJp::Typhoon;

  my $wt = WebService::TenkiJp::Typhoon->new()
  $wt->get_info;
  print $wt->info->text if $wt->is_exist;

=head1 DESCRIPTION

WebService::TenkiJp::Typhoon is Typhoon Weather NEWS client for Perl at Tenki.jp.

=cut

use strict;
use warnings;
use Carp;
use WWW::Mechanize;
use Web::Scraper;
use base qw/Class::Accessor::Fast/;

__PACKAGE__->mk_accessors(qw/info exist/);

our $VERSION = '0.1';

=head1 CONSTRUCTOR AND STARTUP

=head2 new
Creates and returns a new WebService::TenkiJp::Typhoon object.:

my $wt = WebService::TenkiJp::Typhoon->new(
  #option
  agent  => q{user agent},
);

=cut

sub new {
  my $class = shift;
  my %args  = @_;
  my $agent = delete $args{'agent'} || q{Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20100101 Firefox/8.0};
  $args{'mech'}      = WWW::Mechanize->new( agent=> $args{'agent'} );
  $args{'base_url'}  = 'http://tenki.jp';
  my $self = bless {%args}, $class;
  return $self;
}

sub get_info {
  my $self = shift;
  my $mech = $self->{mech};
  my $res  = $mech->get("@{[$self->{base_url}]}/typhoon/");
  my $data = $self->_parse($res->decoded_content) || '';
  $self->exist(1) if $data;
  $self->info($data);
  return $data;
}

=head1 PRIVATE METHODS

=over

=item B<_parse>

scrape a info HTML.

=cut

sub _parse {
  my $self = shift;
  my $html = shift;
  my $scraper = scraper
  {
    process '//div[@id="regionWarningBox"]',
      'data' => scraper
    {
      process '//p[1]',
        description => 'TEXT'
    };
    result 'data';
  };
  return $scraper->scrape($html);
}

=back

=head1 AUTHOR

Likkradyus E<lt>git {at} li.que.jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
