From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Date: Thu, 13 Sep 2018 15:52:21 +0200
Message-ID: <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913050301.GA26367@ip-172-31-15-78>
Sender: linux-kernel-owner@vger.kernel.org
To: kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 13, 2018 at 7:03 AM Kevin Easton <kevin@guarana.org> wrote:
> Yes.  It's also how most get/put APIs already work in the kernel, eg
> kref_get/put (mostly because they tend to be 'getting/putting' an
> already-initialized object, though).

Right; in this case the object wouldn't be initialized yet, which
might defeat the purpose, since one advantage of the & way you
mentioned is _put modifies the context.

Andy - any opinions on this? The tl;dr is:

1) what we have now:

simd_context_t simd_context = simd_get();
for (item in items) {
    do_something(item);
    simd_context = simd_relax(simd_context);
}
simd_put();

2) what kevin is proposing:

simd_context_t simd_context;

simd_get(&simd_context);
for (item in items) {
    do_something(item);
    simd_relax(&simd_context);
}
simd_put(&simd_context);

I can see pros and cons of each approach.
