From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH 0/3] Virtual huge zero page
Date: Mon, 01 Oct 2012 10:52:06 -0700
Message-ID: <5069D846.6000104@linux.intel.com>
References: <1348875441-19561-1-git-send-email-kirill.shutemov@linux.intel.com> <20120929134811.GC26989@redhat.com> <5069B804.6040902@linux.intel.com> <20121001163118.GC18051@redhat.com> <5069CCF9.7040309@linux.intel.com> <20121001172624.GD18051@redhat.com> <5069D3D8.9070805@linux.intel.com> <20121001173604.GC20915@shutemov.name> <5069D4D3.1040003@linux.intel.com> <20121001174420.GA21490@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121001174420.GA21490@shutemov.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 10/01/2012 10:44 AM, Kirill A. Shutemov wrote:
> On Mon, Oct 01, 2012 at 10:37:23AM -0700, H. Peter Anvin wrote:
>> One can otherwise argue that if hzp doesn't matter for except in a small
>> number of cases that we shouldn't use it at all.
> 
> These small number of cases can easily trigger OOM if THP is enabled. :)
> 

And that doesn't happen in any conditions that *aren't* helped by hzp?

	-hpa
