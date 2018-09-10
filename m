From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH 1/8] start unifying termios convertors
Date: Mon, 10 Sep 2018 09:32:34 +0100
Message-ID: <3018.1536568354@warthog.procyon.org.uk>
References: <20180910045227.9895-1-viro@ZenIV.linux.org.uk> <20180910044937.GJ19965@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Content-ID: <3017.1536568354.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> +static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
> +						 struct ktermios *k)
> +{
> +	int err;
> +	err  = put_user(k->c_iflag, &u->c_iflag);
> +	err |= put_user(k->c_oflag, &u->c_oflag);
> +	err |= put_user(k->c_cflag, &u->c_cflag);
> +	err |= put_user(k->c_lflag, &u->c_lflag);
> +	err |= put_user(k->c_line, &u->c_line);
> +	err |= copy_to_user(u->c_cc, k->c_cc, NCCS);
> +	if (!(k->c_lflag & ICANON)) {
> +		err |= put_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
> +		err |= put_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
> +	} else {
> +		err |= put_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
> +		err |= put_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
> +	}
> +	err |= put_user(k->c_ispeed, &u->c_ispeed);
> +	err |= put_user(k->c_ospeed, &u->c_ospeed);
> +	return err;
> +}

Can you make this use || instead of |= ?  That way if put_user() uses a
goto-out-of-asm it may be a lot more efficient, both in the normal case and
the error case.

David
