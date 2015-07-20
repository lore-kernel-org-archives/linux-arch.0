From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2 1/3] drivers/xen/preempt: use need_resched()
 instead of should_resched()
Date: Mon, 20 Jul 2015 14:41:42 +0100
Message-ID: <55ACFA96.9060102@citrix.com>
References: <20150715095201.12246.49283.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:46194 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbbGTNlq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2015 09:41:46 -0400
In-Reply-To: <20150715095201.12246.49283.stgit@buzz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linuxppc-dev@lists.ozlabs.org

On 15/07/15 10:52, Konstantin Khlebnikov wrote:
> This code is used only when CONFIG_PREEMPT=n and only in non-atomic context:
> xen_in_preemptible_hcall is set only in privcmd_ioctl_hypercall().
> Thus preempt_count is zero and should_resched() is equal to need_resched().

Applied to for-linus-4.3, thanks.

David
