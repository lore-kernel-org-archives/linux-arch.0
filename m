From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
Date: Wed, 14 Dec 2011 16:39:56 +0200
Message-ID: <4EE8B53C.6070502@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <4EDF7B0D.4060001@redhat.com> <20111214121622.GB18317@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111214121622.GB18317@amt.cnet>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Eric B Munson <emunson@mgebm.net>, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/14/2011 02:16 PM, Marcelo Tosatti wrote:
> > Having this controlled from userspace means it doesn't work for SIGSTOP
> > or for long scheduling delays.  What about doing this automatically
> > based on preempt notifiers?
>
> Long scheduling delays should be considered hangups from the guest
> perspective.

Why?  To the guest it looks like slow hardware, but it will interpret it
as a softlockup.

> About SIGSTOP, that is a corner case. Unsure if its even properly supported 
> by QEMU.

It works from my experience.

-- 
error compiling committee.c: too many arguments to function
