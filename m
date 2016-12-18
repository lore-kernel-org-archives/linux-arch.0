From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Sun, 18 Dec 2016 12:03:34 +0100
Message-ID: <8311f14c-3d1e-6354-323a-87701cabaa97@broadcom.com>
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl>
 <7212667f-f508-2b41-a380-8f736814d8cc@suse.cz>
 <CA+55aFxjJbAXRq2HSxhfn2gWsGiLPTcqoRrrDLJrLd2vFLu9YQ@mail.gmail.com>
 <5ee08a93-6b17-d1c2-af1c-ab9aa218903c@suse.cz>
 <CA+55aFzRqCYxkqpHioWz-o4WPTDbFmmbHNWFm2oGkYObNOQX=w@mail.gmail.com>
 <9dec52ac-dc82-73c5-6b36-b5eb7cc052fa@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <9dec52ac-dc82-73c5-6b36-b5eb7cc052fa@suse.cz>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 18-12-2016 11:49, Jiri Slaby wrote:
> On 12/18/2016, 12:59 AM, Linus Torvalds wrote:
>> On Sat, Dec 17, 2016 at 12:57 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>>>
>>> Yes, disk drivers won't load:
>>> [    2.141973] virtio_pci: disagrees about version of symbol mcount
>>> [    2.144415] virtio_pci: Unknown symbol mcount (err -22)
>>
>> This makes no sense.
>>
>> mcount isn't even one of the symbols that the patch by Adam is touching.
> 
> asm-prototypes.h in his patch includes asm/ftrace.h, where the function
> is declared. That should be enough IIUC scripts/Makefile.build.
> 
>> There's something else screwed up here. Not to mention that others
>> don't have your issue.
> 
> I suppose people don't run i386 kernels or have different config.
> 
>> Do you have some other hacks in this area? Are you testing actual
>> plain 4.9, or do you (for example) still carry Arnd's patch around
>> that turned out to not work (reverted by f27c2f69cc8e in my tree)?
> 
> Not at all. This was plain 4.9 packaged by suse -- only rpm-related
> fixes. I tried plain 4.9 without rpm right now with the same output:
> # insmod soundcore.ko
> [   31.582326] soundcore: disagrees about version of symbol mcount
> [   31.586183] soundcore: Unknown symbol mcount (err -22)
> insmod: ERROR: could not insert module soundcore.ko: Invalid parameters

I hit an mcount issue a while back (years?) which was due to building a
driver with gcc v4.x while kernel was built using gcc v4.y. Not claiming
that is your issue though.

Regards,
Arend
