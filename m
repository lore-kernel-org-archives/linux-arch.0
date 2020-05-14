From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Thu, 14 May 2020 16:49:51 +0200
Message-ID: <20200514144951.GL18353@8bytes.org>
References: <20200513152137.32426-1-joro@8bytes.org>
 <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Joerg Roedel <jroedel@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 13, 2020 at 09:01:04AM -0700, Andy Lutomirski wrote:
> Assuming the missing cleanup at the end gets done:
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> grumpily acked, anyway.

Thanks, I updated patch 7 and added your acks, will send a v3 probably
tomorrow.


	Joerg
