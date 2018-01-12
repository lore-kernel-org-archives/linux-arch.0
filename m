From: Christopher Lameter <cl@linux.com>
Subject: RE: [PATCH 04/36] usercopy: Prepare for usercopy whitelisting
Date: Fri, 12 Jan 2018 09:56:21 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1801120955540.12791@nuc-kabylake>
References: <1515531365-37423-1-git-send-email-keescook@chromium.org> <1515531365-37423-5-git-send-email-keescook@chromium.org> <alpine.DEB.2.20.1801101219390.7926@nuc-kabylake> <b8c3f85827ca493e9f4517f646ac97da@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8c3f85827ca493e9f4517f646ac97da@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 12 Jan 2018, David Laight wrote:

> > Hmmm... At some point we should switch kmem_cache_create to pass a struct
> > containing all the parameters. Otherwise the API will blow up with
> > additional functions.
>
> Or add an extra function to 'configure' the kmem_cache with the
> extra parameters.

We probably need even more configurability if we add callbacks for object
reclaim / moving.
