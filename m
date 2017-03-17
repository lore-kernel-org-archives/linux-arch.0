From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/6] x86/mm/pat: Add 5-level paging support
Date: Fri, 17 Mar 2017 20:49:35 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703172049100.3790@nanos>
References: <20170317185515.8636-1-kirill.shutemov@linux.intel.com> <20170317185515.8636-4-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdCQTtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2017 15:49:55 -0400
In-Reply-To: <20170317185515.8636-4-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, 17 Mar 2017, Kirill A. Shutemov wrote:

> Straight-forward extension of existing code to support additional page
> table level.

Nicely done!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
