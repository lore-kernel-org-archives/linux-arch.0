From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: The type of bitops
Date: Tue, 07 May 2013 16:17:27 -0700
Message-ID: <51898B87.9020005@mit.edu>
References: <51884263.4020608@zytor.com> <CA+55aFzwjQ03ZA71rgKMhCqh_+1fcMbPJUK3upcOacX2F8+Z9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzwjQ03ZA71rgKMhCqh_+1fcMbPJUK3upcOacX2F8+Z9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 05/06/2013 05:51 PM, Linus Torvalds wrote:
> The only place where the actual size of the data matters is in the
> underlying bitop bitmap itse;f, and that has always been defined to be
> an array of "unsigned long", and we long logn since made sure people
> aren't confused about that. But the index? It's just a number, there's
> no structure associated with it. Somebody might use an "unsigned char"
> as the index into a bitmap, and the operations fundamentally wouldn't
> care - casting the bit index it to an "int" (or a "long") doesn't
> change the operation.

The one and only time I tried to use this, I thought this was odd.  Long
has a different size on 32 vs 64 bit architectures, and bit ops seem
like they'd want to be the same size everywhere so you can allocate the
appropriate number of bits.  (Also, if you only want 32 bits, you have
to do some evil cheating, and I don't trust casting int* to long* on
big-endian architectures.)

Would offering a u32* option make sense?

--Andy
