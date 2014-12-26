From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 26/38] nios2: drop _PAGE_FILE and pte_file()-related helpers
Date: Fri, 26 Dec 2014 13:52:27 +0800
Message-ID: <CAFiDJ59P7DPTfBN5PrhXjTLhku0U+ZYBv_0qdmjtbBNN0T2h3A@mail.gmail.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
	<1419423766-114457-27-git-send-email-kirill.shutemov@linux.intel.com>
	<20141225123014.GO16916@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20141225123014.GO16916@distanz.ch>
Sender: owner-linux-mm@kvack.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 25, 2014 at 8:30 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> On 2014-12-24 at 13:22:34 +0100, Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
>> We've replaced remap_file_pages(2) implementation with emulation.
>> Nobody creates non-linear mapping anymore.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Ley Foon Tan <lftan@altera.com>
>
> Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Ley Foon Tan <lftan@altera.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
