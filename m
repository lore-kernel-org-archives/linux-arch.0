Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:56443 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbdC1W20 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Mar 2017 18:28:26 -0400
Subject: Re: [PATCH 3/8] x86/mm: Define virtual memory map for 5-level paging
References: <20170327162925.16092-1-kirill.shutemov@linux.intel.com>
 <20170327162925.16092-4-kirill.shutemov@linux.intel.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1ae86ad3-deae-1b27-d7a9-ea6b20edc039@zytor.com>
Date: Tue, 28 Mar 2017 15:21:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170327162925.16092-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170328222139.DxgRvKUwpdMAnP-K_qKUMz94NGf1XodCcC7BiBVUxQE@z>

On 03/27/17 09:29, Kirill A. Shutemov wrote:
> +fffe000000000000 - fffe007fffffffff (=39 bits) %esp fixup stacks

Why move this?

	-hpa
