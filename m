From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 13:52:20 -0700
Message-ID: <20100331135220.c6695a51.akpm@linux-foundation.org>
References: <20100325194100.GA2364@debian>
	<20100331134048.da4e35a7.akpm@linux-foundation.org>
	<4BB3B4DB.7040904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45879 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752990Ab0CaVH5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 17:07:57 -0400
In-Reply-To: <4BB3B4DB.7040904@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, hpa@zytor.com, penberg@cs.helsinki.fi, cl@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org

On Wed, 31 Mar 2010 13:47:23 -0700
Yinghai Lu <yinghai@kernel.org> wrote:

> spin_unlock_irq from arm is different from other archs?

No, spin_unlock_irq() unconditionally enables interrupts on all
architectures.
