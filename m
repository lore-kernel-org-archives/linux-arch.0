From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [GIT PULL] Disintegrate the User API from the kernel headers
Date: Tue, 14 Aug 2012 19:26:40 +0200
Message-ID: <502A8A50.4080308@hartkopp.net>
References: <5725.1343931663@warthog.procyon.org.uk> <27564.1343122707@warthog.procyon.org.uk> <31633.1344950521@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:48763 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab2HNR0l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:26:41 -0400
In-Reply-To: <31633.1344950521@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, mkl@pengutronix.de, arnd@arndb.de, tglx@linutronix.de, mtk.manpages@gmail.com, hpa@zytor.com, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 14.08.2012 15:22, David Howells wrote:

> Hi Linus,
> 
>>> Could you please pull this tree at the _end_ of this merge window?
>>>
>>> The patches therein extract the Userspace API bits from the various header
>>> files named in the Kbuild files and separate them out into their own files.
>>> The original files are then given #includes to the new files.
>>
>> I've been keeping this regenerated.  Assuming nothing more is pulled in this
>> merge window, it is ready to pull and should just apply on top of your tree.
>> If you do pull more, it will likely need regenerating again.
> 
> Are you still considering pulling this?  Some of the patches needed tweaking
> to apply due to fixes you've pulled changing headers, so I've regenerated the
> patches again on top of your tree as of the morning of the 14th (UK time).
> See tag:
> 
> 	uapi-post-split-20120814
> 
> The old tags are still around.  Interestingly,
> 
> 	git diff uapi-post-split-201208{03,14} -- arch/*/include include >/tmp/a.diff
> 
> shows a change in the user API for linux/can.h:
> 
> -#define CANFD_NOHDR 0x01 /* frame without high data rate */
> -#define CANFD_NOEDL 0x02 /* frame without extended data length */
> -#define CANFD_ESI   0x04 /* error state indicator */
> +#define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
> +#define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
> 
> from commit 035534ed3377d9def2c17717899fd64a111a785b.  Is this permissible as
> it breaks the userspace API?  Should this part of the patch be reverted?
> 
> I compile tested with x86_64 allyesconfig and i386 allmodconfig in the source
> dir, and arm, m68k, ia64 and s390 defconfigs + CONFIG_HEADERS_CHECK in a
> separate build directory.
> 
> David


Hello David,

the defines have been integrated in his 3.6 merge window and have been changed
the way above after 3.6-rc1 and are now pulled into Linus tree.

The defines are relevant for upcoming tools and drivers (for hardware that
will become available in Q4/2012). So we're currently not breaking any
Userspace API. After it turned out that one of the bits was misleading i
wanted to fix the bits ASAP, so that the final 3.6 will contain the agreed
information and final userspace API for CAN FD.

Currently no-one is referencing these bits inside the kernel. And the only one
that's working on adapting the userspace tools is currently me :-)

So no need to revert anything ...

Sorry for the confusion this caused for your process.

Best regards,
Oliver
