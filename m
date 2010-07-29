From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 2/4] module linker script: coalesce function and data sections
Date: Thu, 29 Jul 2010 03:24:36 +0200
Message-ID: <201007290324.36745.vda.linux@googlemail.com>
References: <1280360876-2571-3-git-send-email-vda.linux@googlemail.com> <1280360876-2571-1-git-send-email-vda.linux@googlemail.com> <29025.1280363105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <29025.1280363105@redhat.com>
Content-Disposition: inline
Sender: linux-parisc-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Matt Fleming <matt@console-pimps.org>, Arnd Bergmann <arnd@arndb.de>, Anders Kaseorg <andersk@mit.edu>, Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Thursday 29 July 2010 02:25, David Howells wrote:
> Denys Vlasenko <vda.linux@googlemail.com> wrote:
> 
> > +	.data   0 : AT(0) { *(.data .data.[A-Za-z0-9_$^]*) }
> > +	.bss    0 : AT(0) { *(.bss .bss.[A-Za-z0-9_$^]*) }
> 
> What about .sdata and .sbss sections produced by arches that support small
> data sections?

linker groups all similarly-named input sections into one output section
with the same name, if the name does not match any rule in the linker
script.

Basically, it should work as if there is a rule:

.sbss    0 : AT(0) { *(.sbss) }

-- 
vda
