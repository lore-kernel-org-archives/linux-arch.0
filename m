From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 05/36] usercopy: WARN() on slab cache usercopy region violations
Date: Wed, 10 Jan 2018 12:14:07 -0800
Message-ID: <CAGXu5jLZ_SVrN6XNSQQFm7W9giD7zh-gmz7Q5HmMnuPMbkES8g@mail.gmail.com>
References: <1515531365-37423-1-git-send-email-keescook@chromium.org>
 <1515531365-37423-6-git-send-email-keescook@chromium.org> <alpine.DEB.2.20.1801101229380.7926@nuc-kabylake>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.DEB.2.20.1801101229380.7926@nuc-kabylake>
Sender: owner-linux-mm@kvack.org
To: Christopher Lameter <cl@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>, Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kern>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 10, 2018 at 10:31 AM, Christopher Lameter <cl@linux.com> wrote:
> On Tue, 9 Jan 2018, Kees Cook wrote:
>
>> @@ -3823,11 +3825,9 @@ int __check_heap_object(const void *ptr, unsigned long n, struct page *page,
>
> Could we do the check in mm_slab_common.c for all allocators and just have
> a small function in each allocators that give you the metadata needed for
> the object?

That could be done, but there would still need to be some
implementation-specific checks in the per-implementation side (e.g.
red-zone, etc). I'll work up a patch and see if it's less ugly than
what I've currently got. :)

>> + * carefully audit the whitelist range).
>> + */
>>  int report_usercopy(const char *name, const char *detail, bool to_user,
>>                   unsigned long offset, unsigned long len)
>>  {
>
> Should this not be added earlier?

This seemed like the best place to add this since it's where the WARN
is being added, so it's a bit more help for anyone looking at the
code.

-Kees

-- 
Kees Cook
Pixel Security

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
