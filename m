From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Date: Wed, 20 Feb 2019 13:03:15 -0800
Message-ID: <20190220210315.GM12668@bombadil.infradead.org>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
 <20190219053205.GA124985@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190219053205.GA124985@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yu Zhao <yuzhao@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>, Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Chintan Pandya <cpandya@codeaurora.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 18, 2019 at 10:32:05PM -0700, Yu Zhao wrote:
> pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
> it's okay to use pgtable_page_ctor() instead only because kernel
> doesn't have thp.

I'm not sure that's true.  I think you can create THPs in vmalloc
these days.  See HAVE_ARCH_HUGE_VMAP which is supported by arm64.
