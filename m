From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Sat, 17 Dec 2016 09:57:47 +0100
Message-ID: <5ee08a93-6b17-d1c2-af1c-ab9aa218903c@suse.cz>
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl>
 <7212667f-f508-2b41-a380-8f736814d8cc@suse.cz>
 <CA+55aFxjJbAXRq2HSxhfn2gWsGiLPTcqoRrrDLJrLd2vFLu9YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxjJbAXRq2HSxhfn2gWsGiLPTcqoRrrDLJrLd2vFLu9YQ@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 12/16/2016, 08:57 PM, Linus Torvalds wrote:
> On Fri, Dec 16, 2016 at 11:55 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> what happened to this? I had to apply this to fix 4.9-pae kernel here.
> 
> Did you actually have to do that?

Yes, disk drivers won't load:
[    2.141973] virtio_pci: disagrees about version of symbol mcount
[    2.144415] virtio_pci: Unknown symbol mcount (err -22)
[    2.164547] virtio_pci: disagrees about version of symbol mcount
[    2.166309] virtio_pci: Unknown symbol mcount (err -22)
[    2.180651] virtio_pci: disagrees about version of symbol mcount
[    2.182823] virtio_pci: Unknown symbol mcount (err -22)
[    2.210943] virtio_pci: disagrees about version of symbol mcount
[    2.220097] virtio_pci: Unknown symbol mcount (err -22)
[    2.220173] ata_piix: disagrees about version of symbol mcount
[    2.220174] ata_piix: Unknown symbol mcount (err -22)

and whole machine gets stuck with systemd waiting for /dev/sd*.

> Because a missing CRC shouldn't be fatal in 4.9.
> 
> What was the failure mode?

I am not sure what you mean? The kernel is rpm-ized 4.9 vanilla and this
is the config:
http://kernel.suse.com/cgit/kernel-source/tree/config/i386/default?h=stable

thanks,
-- 
js
suse labs
