# from the zip clonezilla-live-3.2.2-15-amd64.zip

under  syslinux/syslinux.cfg 


```
# Created by generate-pxe-menu! Do NOT edit unless you know what you are doing! 
# Keep those comment "MENU DEFAULT" and "MENU HIDE"! Do NOT remove them.
# Note!!! If "serial" directive exists, it must be the first directive
default vesamenu.c32
timeout 300
prompt 0
noescape 1
MENU MARGIN 5
 MENU BACKGROUND ocswp.png
# Set the color for unselected menu item and timout message
 MENU COLOR UNSEL 7;32;41 #c0000090 #00000000
 MENU COLOR TIMEOUT_MSG 7;32;41 #c0000090 #00000000
 MENU COLOR TIMEOUT 7;32;41 #c0000090 #00000000
 MENU COLOR HELP 7;32;41 #c0000090 #00000000

# MENU MASTER PASSWD

say **********************************************************************
say Clonezilla, the OpenSource Clone System.
say NCHC Free Software Labs, Taiwan.
say clonezilla.org, clonezilla.nchc.org.tw
say THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
say **********************************************************************

# Allow client to edit the parameters
ALLOWOPTIONS 1

# simple menu title
MENU TITLE clonezilla.org, clonezilla.nchc.org.tw

label Clonezilla live
  MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (VGA 800x600)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=788 net.ifnames=0  nosplash i915.blacklist=yes radeonhd.blacklist=yes nouveau.blacklist=yes vmwgfx.enable_fbdev=1 scsi_mod.use_blk_mq=0 nvme.poll_queues=1
  TEXT HELP
  * Boot menu for BIOS machine
  * Clonezilla live version: 3.2.2-15-amd64. (C) 2003-2025, NCHC, Taiwan
  * Disclaimer: Clonezilla comes with ABSOLUTELY NO WARRANTY
  ENDTEXT

label Clonezilla live (To RAM)
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (VGA 800x600 & To ^RAM)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=788 toram=live,syslinux,EFI,boot,.disk,utils net.ifnames=0  nosplash i915.blacklist=yes radeonhd.blacklist=yes nouveau.blacklist=yes vmwgfx.enable_fbdev=1 scsi_mod.use_blk_mq=0 nvme.poll_queues=1
  TEXT HELP
  All the programs will be copied to RAM, so you can
  remove boot media (CD or USB flash drive) later
  ENDTEXT

label Clonezilla live HiDPI
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (VGA with ^large font & To RAM)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" nomodeset toram=live,syslinux,EFI,boot,.disk,utils net.ifnames=0  nosplash live_console_font_size=16x32
  TEXT HELP
  Large font, all the programs will be copied to RAM, so you can
  remove boot media (CD or USB flash drive) later
  ENDTEXT

label Clonezilla live speech synthesis
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live with ^speech synthesis
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=788 net.ifnames=0  nosplash i915.blacklist=yes radeonhd.blacklist=yes nouveau.blacklist=yes vmwgfx.enable_fbdev=1 scsi_mod.use_blk_mq=0 nvme.poll_queues=1 speakup.synth=soft ---
  TEXT HELP
  * Boot menu for BIOS machine
  * Clonezilla live version: 3.2.2-15-amd64. (C) 2003-2025, NCHC, Taiwan
  * Disclaimer: Clonezilla comes with ABSOLUTELY NO WARRANTY
  ENDTEXT

MENU BEGIN Other modes of Clonezilla live
label Clonezilla live 1024x768
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (VGA 1024x768)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=791 net.ifnames=0  nosplash i915.blacklist=yes radeonhd.blacklist=yes nouveau.blacklist=yes vmwgfx.enable_fbdev=1 scsi_mod.use_blk_mq=0 nvme.poll_queues=1
  TEXT HELP
  VGA mode 1024x768. OK for most of VGA cards.
  ENDTEXT

label Clonezilla live 640x480
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (VGA 640x480)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=785 net.ifnames=0  nosplash i915.blacklist=yes radeonhd.blacklist=yes nouveau.blacklist=yes vmwgfx.enable_fbdev=1 scsi_mod.use_blk_mq=0 nvme.poll_queues=1
  TEXT HELP
  VGA mode 640x480. OK for most of VGA cards.
  ENDTEXT

label Clonezilla live KMS
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (^KMS)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=791 net.ifnames=0  nosplash
  TEXT HELP
  KMS mode. OK for ATI, Intel and NVIDIA VGA cards.
  ENDTEXT

label Clonezilla live KMS & To RAM
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (KMS & To RAM)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=791 toram=live,syslinux,EFI,boot,.disk,utils net.ifnames=0  nosplash
  TEXT HELP
  KMS mode. OK for ATI, Intel and NVIDIA VGA cards.
  ENDTEXT

label Clonezilla live KMS, To RAM & large font
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (KMS with ^large font & To RAM)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" vga=791 toram=live,syslinux,EFI,boot,.disk,utils net.ifnames=0  nosplash live_console_font_size=16x32
  TEXT HELP
  KMS mode. OK for ATI, Intel and NVIDIA VGA cards.
  ENDTEXT

label Clonezilla live without framebuffer
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (Safe graphic settings, vga=normal)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" net.ifnames=0 nomodeset vga=normal nosplash
  TEXT HELP
  Disable console frame buffer support
  ENDTEXT

label Clonezilla live failsafe mode
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Clonezilla live (Failsafe mode)
  # MENU PASSWD
  kernel /live/vmlinuz
  append initrd=/live/initrd.img boot=live union=overlay username=user config components quiet loglevel=3 ocs_1_cpu_udev noswap edd=on nomodeset enforcing=0 noeject locales= keyboard-layouts= ocs_live_run="ocs-live-general" ocs_live_extra_param="" ocs_live_batch="no" acpi=off irqpoll noapic noapm nodma nomce nolapic nosmp net.ifnames=0 nomodeset vga=normal nosplash
  TEXT HELP
  acpi=off irqpoll noapic noapm nodma nomce nolapic 
  nosmp nomodeset vga=normal nosplash
  ENDTEXT

MENU END
label local
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Local operating system in harddrive (if available)
  # MENU PASSWD
  # 2 method to boot local device:
  # (1) For localboot 0, it is decided by boot order in BIOS, so uncomment the follow 1 line if you want this method:
  # localboot 0

  # (2) For chain.c32, you can assign the boot device.
  # Ref: extlinux.doc from syslinux
  # Syntax: APPEND [hd|fd]<number> [<partition>]
  # [<partition>] is optional.
  # Ex:
  # Second partition (2) on the first hard disk (hd0);
  # Linux would *typically* call this /dev/hda2 or /dev/sda2, then it's "APPEND hd0 2"
  #
  kernel chain.c32
  append hd0
  TEXT HELP
  Boot local OS from first hard disk if it's available
  ENDTEXT

MENU BEGIN Memtest & FreeDOS

# Note! *.bin is specially purpose for syslinux, 
# Do NOT use memtest.bin, use memtest instead of memtest.bin
label memtest (32 bits)
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Memory test using Memtest86+ (32 bits)
  # MENU PASSWD
  kernel /live/mt86+x32.mbr
  TEXT HELP
  Run memory test using 32-bit Memtest86+
  ENDTEXT


# Note! *.bin is specially purpose for syslinux, 
# Do NOT use memtest.bin, use memtest instead of memtest.bin
label memtest (64 bits)
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Memory test using Memtest86+ (64 bits)
  # MENU PASSWD
  kernel /live/mt86+x64.mbr
  TEXT HELP
  Run memory test using 64-bit Memtest86+
  ENDTEXT

label FreeDOS
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL FreeDOS
  # MENU PASSWD
  kernel memdisk
  append initrd=/live/freedos.img
  TEXT HELP
  Run FreeDOS
  ENDTEXT

MENU END
label iPXE
  # MENU DEFAULT
  # MENU HIDE
  MENU LABEL Network boot via iPXE
  # MENU PASSWD
  kernel /live/ipxe.lkn
  TEXT HELP
  Run iPXE to enable network (PXE) boot
  ENDTEXT

MENU END

```