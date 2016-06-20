Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34535 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932377AbcFTNgR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2016 09:36:17 -0400
Date: Mon, 20 Jun 2016 15:36:14 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 06/13] fork: Add generic vmalloced stack support
Message-ID: <20160620133614.GE9892@dhcp22.suse.cz>
References: <cover.1466192946.git.luto@kernel.org>
 <44f658aacbabd9d1689b3e0aae60ee8746881eff.1466192946.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f658aacbabd9d1689b3e0aae60ee8746881eff.1466192946.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160620133614.kShgBvPDbklIFzgbjE_gFIecbvdFCRZ0S2bc1A9ACt4@z>

On Fri 17-06-16 13:00:42, Andy Lutomirski wrote:
> If CONFIG_VMAP_STACK is selected, kernel stacks are allocated with
> vmalloc_node.

I like this! It also reduces demand for higher order (order-2) pages
considerably which is a great plus on its own. I would be little bit
worried about the performance because vmalloc wasn't the fastest one
AFAIR. Have you tried to measure that?
