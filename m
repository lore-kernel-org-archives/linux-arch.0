From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve
 lpage NUMA support
Date: Mon, 29 Jun 2009 19:20:53 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0906291920100.32637@gentwo.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org> <20090624165508.30b88343.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp3.ultrahosting.com ([74.213.175.254]:34534 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753834AbZF2XVQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2009 19:21:16 -0400
In-Reply-To: <20090624165508.30b88343.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de

On Wed, 24 Jun 2009, Andrew Morton wrote:

> I assume from the tremendous number of for_each_possible_cpu()s that
> CPU hotplug awareness won't be happening.

Per cpu areas are allocated for all possible processors. No need to handle
offlining and onlining them.
