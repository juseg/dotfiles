#!/bin/bash

# Concatenate PISM extra and ts files.

# After Piz Daint will come back into function, this script could also move
# single files y???????-{extra,ts}.nc to {extra,ts}.nc for confirmity. The
# script pism.sync.output.sh could then avoid y???????-{extra,ts}.nc to avoid
# cluttering local hard drives. The drawback is, that I will have to wait for
# job chains to complete before plotting them.

# move to pism input/output directory
cd ~/pism

# find all folders containg extra files
find output -name y*-extra.nc -printf "%h\n" | uniq -c | while read n d
do

    # if there is more than one extra file
    if [ "$n" -gt 1 ]
    then

        # for each file type
        for type in extra ts
        do

            # concatenate files
            ifile=$d/y*-$type.nc
            ofile=$d/$type.nc
            if ! [ -f $ofile ]
            then
                echo "Assembling $ofile ..."
                ncrcat $ifile $ofile
            fi

        done

    fi

done
