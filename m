From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/4] module linker script: coalesce function and data sections
Date: Thu, 29 Jul 2010 10:09:57 +0100
Message-ID: <30881.1280394597@redhat.com>
References: <201007290324.36745.vda.linux@googlemail.com> <1280360876-2571-3-git-send-email-vda.linux@googlemail.com> <1280360876-2571-1-git-send-email-vda.linux@googlemail.com> <29025.1280363105@redhat.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <201007290324.36745.vda.linux@googlemail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: dhowells@redhat.com, Michal Marek <mmarek@suse.cz>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Matt Fleming <matt@console-pimps.org>, Arnd Bergmann <arnd@arndb.de>, Anders Kaseorg <andersk@mit.edu>, Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

Denys Vlasenko <vda.linux@googlemail.com> wrote:

> linker groups all similarly-named input sections into one output section
> with the same name, if the name does not match any rule in the linker
> script.
> 
> Basically, it should work as if there is a rule:
> 
> .sbss    0 : AT(0) { *(.sbss) }

Okay, thanks.

David
