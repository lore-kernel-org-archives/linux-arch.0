From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: Testing of function/data-sections on linux-2.6.35-rc4
Date: Mon, 19 Jul 2010 01:31:56 +0200
Message-ID: <201007190131.56633.vda.linux@googlemail.com>
References: <201007181703.17022.vda.linux@googlemail.com> <AANLkTin-9VsTJxGclRUrJIizn9aDZ6pjxmByBCWB0Hqr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <AANLkTin-9VsTJxGclRUrJIizn9aDZ6pjxmByBCWB0Hqr@mail.gmail.com>
Content-Disposition: inline
Sender: linux-parisc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.cz>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sunday 18 July 2010 20:24, Geert Uytterhoeven wrote:
> On Sun, Jul 18, 2010 at 17:03, Denys Vlasenko <vda.linux@googlemail.com> wrote:
> > I am sending this email from the machine which runs the kernel
> > built with -ffunction-sections -fdata-sections --gc-sections.
> 
> (sorry for the previous HTML-email)
> 
> For the record, what are the metrics of this kernel vs. the standard one?

Kernel:

   text    data     bss     dec     hex filename
8299299  857324  785348 9941971  97b3d3 linux-2.6.35-rc4.obj/vmlinux
7656461  841508  783700 9281669  8da085 linux-2.6.35-rc4-fs.obj/vmlinux
7566908  832388  717844 9117140  8b1dd4 linux-2.6.35-rc4-fsgs.obj/vmlinux

The largest module in my build:
   text    data     bss     dec     hex filename
 451009   54640    2224  507873   7bfe1 linux-2.6.35-rc4.obj/fs/xfs/xfs.ko
 450519   54292    2202  507013   7bc85 linux-2.6.35-rc4-fs.obj/fs/xfs/xfs.ko
 450521   54292    2202  507015   7bc87 linux-2.6.35-rc4-fsgs.obj/fs/xfs/xfs.ko


-- 
vda
