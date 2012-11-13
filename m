From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [RFC PATCH v1 14/31] ARC: syscall support
Date: Tue, 13 Nov 2012 13:01:35 +0100
Message-ID: <CACM3HyFE-S2NM75qVS2Fhhm8YoP1jH4mS41aZ5B1gW2wo-Q99g@mail.gmail.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com>
	<1352281674-2186-15-git-send-email-vgupta@synopsys.com>
	<201211071421.39523.arnd@arndb.de>
	<509CD1D1.3050105@imgtec.com>
	<50A231EE.7050204@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50A231EE.7050204@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

On 13 November 2012 12:41, James Hogan <james.hogan@imgtec.com> wrote:
> The uClibc patches I mentioned have been posted, see here:
>
> http://lists.busybox.net/pipermail/uclibc/2012-November/047110.html
>
> Please do try them out and provide any feedback.
>

Hi James,

Many thanks for picking this up...

This is the third time around for trying to get this into uClibc as
Mark Salter also pushed a patch set which got about as much feedback
(almost none) on the list as mine did.  His patchset, like yours,
preferred the "old" syscalls when present.

...and that gets me around to the question:  why should the "old"
syscalls be preferred?  I'm specifically asking this here because I'm
curious what the kernel developers' take on this is.

Regards,
Jonas
