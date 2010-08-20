Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38864 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab0HTVpf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2010 17:45:35 -0400
Message-ID: <4C6EF747.7070904@redhat.com>
Date: Fri, 20 Aug 2010 17:44:39 -0400
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 4/6] mm: Remove all KM_type arguments
References: <20100819201317.673172547@chello.nl> <20100819202753.773618082@chello.nl>
In-Reply-To: <20100819202753.773618082@chello.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20100820214439.mGLCy96MwS-sq6e2w01aSWpO7o3EasAdFV4odXd45pk@z>

On 08/19/2010 04:13 PM, Peter Zijlstra wrote:
> Do the bulk of the km_type and KM_type removement by script.
>
> git grep -l -e km_type -e KM_ | grep -v xfs | while read file;
> do
> 	quilt add $file;
>          sed -i -e 's/,[[:space:]]*enum km_type type[[:space:]]*//g'         \
>                 -e 's/,[[:space:]]*KM_[[:digit:][:upper:]_]*[[:space:]]*//g' \
>              $file;
> done
>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
