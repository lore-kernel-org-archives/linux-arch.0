From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH 01/20] percpu: fix pcpu_reclaim() locking
Date: Tue, 21 Jul 2009 17:41:47 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0907211741290.25867@gentwo.org>
References: <1248171979-29166-1-git-send-email-tj@kernel.org> <1248171979-29166-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp3.ultrahosting.com ([74.213.175.254]:36781 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754902AbZGUVmd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2009 17:42:33 -0400
In-Reply-To: <1248171979-29166-2-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, benh@kernel.crashing.org, davem@davemloft.net, dhowells@redhat.com, npiggin@suse.de, JBeulich@novell.com, rusty@rustcorp.com.au, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, x86@kernel.org, andi@firstfloor.org



Reviewed-by: Christoph Lameter <cl@linux-foundation.org>
