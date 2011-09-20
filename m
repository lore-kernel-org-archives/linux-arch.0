Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:44260 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab1ITUra (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2011 16:47:30 -0400
Date: Tue, 20 Sep 2011 21:03:51 +0100
From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 0/4] Avoid soft lockup message when KVM is stopped by host
Message-ID: <20110920200351.GH6690@jl-vm1.vm.bytemark.co.uk>
References: <1314660435-23293-1-git-send-email-emunson@mgebm.net>
 <20110830122630.GA19450@amt.cnet>
 <4E5FDBDC.2030302@codemonkey.ws>
 <6c387b0ab0b091253c1a1488dd625b94@mgebm.net>
 <20110909132955.GA19459@amt.cnet>
 <20110913204955.GD9096@mgebm.net>
 <20110915132614.GA7101@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110915132614.GA7101@amt.cnet>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Eric B Munson <emunson@mgebm.net>, Anthony Liguori <anthony@codemonkey.ws>, avi@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm-ppc@vger.kernel.org, aliguori@us.ibm.com, raharper@us.ibm.com, kvm-ia64@vger.kernel.org, Glauber Costa <glommer@gmail.com>, mjwolf@us.ibm.com
Message-ID: <20110920200351.wMtPON_82wEBHBpMMqkqi5amCBb9mk9wzgVFPGT8fiI@z>

Marcelo Tosatti wrote:
> In case the VM stops for whatever reason, the host system is not
> supposed to adjust time related hardware state to compensate, in an
> attempt to present apparent continuous time.
> 
> If you save a VM and then restore it later, it is the guest
> responsability to adjust its time representation.

If the guest doesn't know it's been stopped, then its time
representation will be wrong until it finds out, e.g. after a few
minutes with NTP, or even a seconds can be too long.

That is sad when it happens because it breaks the coherence of any
timed-lease caching the guest is involved in.  I.e. where the guest
acquires a lock on some data object (like a file in NFS) that it can
efficiently access without network round trips (similar to MESI), with
all nodes having agreed that it's coherent for, say, 5 seconds before
renewing or breaking.  (It's just a way to reduce latency.)

But we can't trust CLOCK_MONOTONIC when a VM is involved, it's just
one of those facts of life.  So instead the effort is to try and
detect when a VM is involved and then distrust the clock.

(Non-VM) suspend/resume is similar, but there's usually a way to
be notified about that as it happens.

-- Jamie
