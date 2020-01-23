Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches as
 usercopy caches
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
 <1515636190-24061-10-git-send-email-keescook@chromium.org>
 <9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz>
 <201911121313.1097D6EE@keescook> <201911141327.4DE6510@keescook>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz>
Date: Thu, 23 Jan 2020 09:14:20 +0100
MIME-Version: 1.0
In-Reply-To: <201911141327.4DE6510@keescook>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Rik van Riel <riel@redhat.com>, Matthew Garrett <mjg59@google.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, kernel-hardening@lists.openwall.com, Vlastimil Babka <vbabka@suse.cz>, Michal Kubecek <mkubecek@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200123081420.muT92tBulvLAVFvbLVxKg9B442_DhRtCUeAV5yOReSU@z>

On 14. 11. 19, 22:27, Kees Cook wrote:
> On Tue, Nov 12, 2019 at 01:21:54PM -0800, Kees Cook wrote:
>> How is iucv the only network protocol that has run into this? Do others
>> use a bounce buffer?
> 
> Another solution would be to use a dedicated kmem cache (instead of the
> shared kmalloc dma one)?

Has there been any conclusion to this thread yet? For the time being, we
disabled HARDENED_USERCOPY on s390...

https://lore.kernel.org/kernel-hardening/9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz/

thanks,
-- 
js
suse labs
