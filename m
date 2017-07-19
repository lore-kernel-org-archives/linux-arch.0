From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 2/2] x86/refcount: Implement fast refcount overflow protection
Date: Wed, 19 Jul 2017 16:12:37 -0700
Message-ID: <CAGXu5j+EkpmO2tB71n9rEjb_6GfWza3qBLUDTuhjZwnAYTX5WA@mail.gmail.com>
References: <1500422614-94821-1-git-send-email-keescook@chromium.org>
 <1500422614-94821-3-git-send-email-keescook@chromium.org> <20170719193718.bvkkde5apbboudrk@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-hardening-return-9074-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: keescook@google.com
In-Reply-To: <20170719193718.bvkkde5apbboudrk@treble>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 19, 2017 at 12:37 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> +#define ASM_UNREACHABLE                                                        \
> +       "999: .pushsection .discard.unreachable\n\t"                    \
> +       ".long 999b - .\n\t"                                            \
> +       ".popsection\n\t"

Will this end up running into the same bug fixed with
3d1e236022cc1426b0834565995ddee2ca231cee and the __LINE__ macro? I
could tell under which conditions gcc would do this kind of merging...

-Kees

-- 
Kees Cook
Pixel Security
