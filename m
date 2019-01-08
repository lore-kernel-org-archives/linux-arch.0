From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/5] csky: fixup compile error with pte_alloc
Date: Tue, 8 Jan 2019 09:33:09 -0800
Message-ID: <CAHk-=wh0H6_Vh3XNQ0EKWa96UFkr7j=v-++2L4kraSLR-RVciQ@mail.gmail.com>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org> <1546964798-30067-4-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546964798-30067-4-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <guoren@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, marc.zyngier@arm.com, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Guo Ren <ren_guo@c-sky.com>, Joel Fernandes <joel@joelfernandes.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 8, 2019 at 8:27 AM <guoren@kernel.org> wrote:
>
> +       for (i = 0; i < PAGE_SIZE/sizeof(pte_t); i++)
> +               (pte + i)->pte_low = _PAGE_GLOBAL;

When I first read this, I went "hmm. pte_high is not initialized".

But csky doesn't have a pte_high, and it seems that csky and SH both
decided to call their (single-word) pte member 'pte_low'.

Which is a bit odd, but whatever.

Other than that oddity, it looks fine to me. I assume I'll get a pull
request sooner or later,

              Linus
