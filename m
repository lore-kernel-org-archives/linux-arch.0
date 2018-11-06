From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: + fls-change-parameter-to-unsigned-int.patch added to -mm tree
Date: Tue, 6 Nov 2018 18:14:44 +0300
Message-ID: <20181106151444.GA11221@avx2>
References: <20181105233301.KlgdF%akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105233301.KlgdF%akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: willy@infradead.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 05, 2018 at 03:33:01PM -0800, akpm@linux-foundation.org wrote:

> -static inline int fls(int x)
> +static inline int fls(unsigned int x)
>  {
> -	return fls64((unsigned int) x);
> +	return fls64(x);
>  }

Should it return "unsigned"? Logically it should.
I remember doing this and there was some code size increase :-(
