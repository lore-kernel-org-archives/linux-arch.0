From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The type of bitops
Date: Tue, 07 May 2013 16:18:53 -0700
Message-ID: <51898BDD.90705@zytor.com>
References: <51884263.4020608@zytor.com> <CA+55aFzwjQ03ZA71rgKMhCqh_+1fcMbPJUK3upcOacX2F8+Z9A@mail.gmail.com> <51898B87.9020005@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51898B87.9020005@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 05/07/2013 04:17 PM, Andy Lutomirski wrote:
> 
> The one and only time I tried to use this, I thought this was odd.  Long
> has a different size on 32 vs 64 bit architectures, and bit ops seem
> like they'd want to be the same size everywhere so you can allocate the
> appropriate number of bits.  (Also, if you only want 32 bits, you have
> to do some evil cheating, and I don't trust casting int* to long* on
> big-endian architectures.)
> 
> Would offering a u32* option make sense?
> 

Honestly, the only thing that makes sense on bigendian architectures is
either byte-by-byte elements or counting bit numbers from the MSB, but
that is serious water under the bridge at this point...

	-hpa
