Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691Ab1LVKJG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Dec 2011 05:09:06 -0500
Message-ID: <4EF301B1.1020102@redhat.com>
Date: Thu, 22 Dec 2011 12:08:49 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4 V7] Add ioctl for KVMCLOCK_GUEST_STOPPED
References: <1323978126-13222-1-git-send-email-emunson@mgebm.net> <1323978126-13222-4-git-send-email-emunson@mgebm.net>
In-Reply-To: <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20111222100849.KF9nCc4mzd0kZ0bIPz0auVK8HgmP14ZJHwKd73MiBto@z>

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

