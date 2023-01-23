Hi Jan,

The BIOS only loads 512 bytes from the boot sector into memory. This is where that limitation comes from. To go beyond this, you can either load an external file (what the tutorials do) or load the next successive sectors (some file systems require this during startup.)

In the latter case, just set org 0 and manually set up segments then have the boot code load the rest of itself into memory at 0x7e00. The first k sectors would be reserved for the boot code and file system, if any. The BIOS loads sector 0 to 0x7c00 so the code just needs to load sector 1 to k-1 at 0x7e00. If you are using a file system, these sectors should be marked reserved in the BIOS Parameter Block or equivalent.

If you are booting natively from a CD, note sector size is 2048 bytes rather then 512. We provide our ISO9660 boot code here if interested as it is designed to boot from CD's.

In summary, set org 0, set up initial segments, call BIOS to load sectors 1 to k-1 to 0x7e00 to load the rest of itself, then can proceed with enabling A20, disable hardware interrupts (for now to avoid triple fault in next step) and jump into protected mode.

As EFI has become more relevant, we can also suggest that as an option as you can effectively skip all of the above.

Please let us know if there are any questions, comments, suggestions, or ideas.

~Mike ();
OS Development Series Editor

-----Original Message-----
From: Jan Allersma <kapstok@e.email>
To: neon6000@aol.com
Sent: Wed, Jan 18, 2023 7:07 am
Subject: OS dev tutorial

Hello,
I'm following your [tutorial](http://www.brokenthorn.com/Resources/OSDev6.html) but I get stuck. Instead of a floppy, I use an ISO file on a virtual machine (I am using Linux so I cannot use directly your downloadable examples. I cannot getting it working with multiple binaries.
I was wondering whether it is possible to enable A20 directly and go into protected mode. I assume you can then get outside of the 512 bytes bootloader.
Do you know whether and how it would be possible to get beyond the 512 bytes in a single assembly file?

Kind regards,
Jan Allersma
