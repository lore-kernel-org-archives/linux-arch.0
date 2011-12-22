From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 3/4 V7] Add ioctl for KVMCLOCK_GUEST_STOPPED
Date: Thu, 22 Dec 2011 12:08:49 +0200
Message-ID: <4EF301B1.1020102@redhat.com>
References: <1323978126-13222-1-git-send-email-emunson@mgebm.net> <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/15/2011 09:42 PM, Eric B Munson wrote:
>  
> +4.64 KVMCLOCK_GUEST_PAUSED
> +
> +Capability: basic

Capability: basic means that this ioctl is available on any Linux
version that has KVM (apart from 2.6.2[01], before the ABI was
stabilized).  You need to define a new KVM_CAP, document it, and have
KVM_CHECK_EXTENSION acknowledge it, see the other ioctls for examples.

-- 
error compiling committee.c: too many arguments to function
