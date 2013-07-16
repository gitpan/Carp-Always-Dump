
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Like Carp::Always, but dumps the content of function arguments",
  "dist_author" => [
    "Steven Haryanto <stevenharyanto\@gmail.com>"
  ],
  "dist_name" => "Carp-Always-Dump",
  "dist_version" => "0.02",
  "license" => "perl",
  "module_name" => "Carp::Always::Dump",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Carp::Always" => 0,
    "Data::Dump" => 0,
    "Data::Dump::OneLine" => 0,
    "Monkey::Patch::Action" => 0,
    "perl" => "5.010001"
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
