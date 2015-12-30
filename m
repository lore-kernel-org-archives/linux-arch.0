Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13684 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbbL3Qjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Dec 2015 11:39:51 -0500
From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 03/34] ia64: rename nop->iosapic_nop
Date: Wed, 30 Dec 2015 16:39:48 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F39F9CFDF@ORSMSX114.amr.corp.intel.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
 <1451473761-30019-4-git-send-email-mst@redhat.com>
In-Reply-To: <1451473761-30019-4-git-send-email-mst@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Message-ID: <20151230163948.03CuH6b_tsS_7dMG8_15iz4LFiMObUAr-r95EKt3Jik@z>

> asm-generic/barrier.h defines a nop() macro.
> To be able to use this header on ia64, we shouldn't
> call local functions/variables nop().
>
> There's one instance where this breaks on ia64:
> rename the function to iosapic_nop to avoid the conflict.

Acked-by: Tony Luck <tony.luck@intel.com>

