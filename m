From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 3/4 V10] Add ioctl for KVMCLOCK_GUEST_STOPPED
Date: Mon, 30 Jan 2012 17:49:46 +0200
Message-ID: <4F26BC1A.8060002@redhat.com>
References: <1326825641-15765-1-git-send-email-emunson@mgebm.net> <1326825641-15765-4-git-send-email-emunson@mgebm.net> <4F26B220.9050101@redhat.com> <20120130153244.GA6875@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120130153244.GA6875@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@web.de>
List-Id: linux-arch.vger.kernel.org

On 01/30/2012 05:32 PM, Eric B Munson wrote:
> > 
> > Can you point me to the discussion that moved this to be a vm ioctl?  In
> > general vm ioctls that do things for all vcpus are racy, like here. 
> > You're accessing variables that are protected by the vcpu mutex, and not
> > taking the mutex (nor can you, since it is held while the guest is
> > running, unlike most kernel mutexes).
> > 
>
> Jan Kiszka suggested that becuase there isn't a use case for notifying
> individual vcpus (can vcpu's be paused individually?

They can, though the guest will grind to a halt very soon.

> ) that it makes more sense
> to have a vm ioctl.
>
> http://thread.gmane.org/gmane.comp.emulators.qemu/131624
>
> If the per vcpu ioctl is the right choice I can resend those patches.

The races are solvable but I think it's easier in userspace.  It's also
more flexible, though I don't really see a use for this flexibility.

-- 
error compiling committee.c: too many arguments to function
