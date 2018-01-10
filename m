From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH 05/36] usercopy: WARN() on slab cache usercopy region
 violations
Date: Wed, 10 Jan 2018 12:31:47 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1801101229380.7926@nuc-kabylake>
References: <1515531365-37423-1-git-send-email-keescook@chromium.org> <1515531365-37423-6-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1515531365-37423-6-git-send-email-keescook@chromium.org>
Sender: owner-linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Tue, 9 Jan 2018, Kees Cook wrote:

> @@ -3823,11 +3825,9 @@ int __check_heap_object(const void *ptr, unsigned long n, struct page *page,

Could we do the check in mm_slab_common.c for all allocators and just have
a small function in each allocators that give you the metadata needed for
the object?

> + * carefully audit the whitelist range).
> + */
>  int report_usercopy(const char *name, const char *detail, bool to_user,
>  		    unsigned long offset, unsigned long len)
>  {

Should this not be added earlier?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
