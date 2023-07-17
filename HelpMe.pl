use Try::Tiny;

my ($package, $function) = @ARGV;
my $obj;
if (!$package) {
   $help = "To use the HelpMe command you will use this format"
            ."\n\tHelpMe <Package Name> <Function Name>\n"
            ."\n\t<Package Name> : This is an optional parameter which determines which package you would like to learn more about"
            ."\n\t\t formatting of this parameter can be either with or without the '.pm' package suffix"
            ."\n\t\t this call will also provide a list of functions in the object if no <function> is definied"
            ."\n\t<Function Name> : This is an optional parameter which determines which class function you would like to learn more about"
            ."\n\t\t formatting of this parameter will be the name of the subroutine"
            ."\n\t\t this string will highlight the description of the class subroutine, parameters, and return values"
            ."";
   print $help;
   die "\n";
}

if  (!$function) {
   $function = "";
}

$package_name = "$package";
if (!($package_name =~ /.pm$/)){
   $package_name .= '.pm';
}else{
   $package =~ s/.pm//;
}

require $package_name;

if (-e $package)
{
   my $obj = $package->new();
   my $help = "";
   try {
      $help = $obj->help($function);
   }catch{
      $help = "\n$package hasn't implemented a help function yet, either make it yourself or go bother Tariq\n";
   };

   print $help;
}
1;
