Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AE3C1F
	for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781654776; cv=pass; b=iLxLydqVskcU3VHh7srGOvC/ejimqP37E9Ah05+R8fFGzZm9P8NvfjVM5aiqGPnnz3cfl3uPiwCkEJlzdie3wMyfRKdr/VPHWczzRJFGog6oTX7XnhphvuUPIQKR3K/msi8yG11u8dtOT5Q20KGXKdll1SHT3Pow8St1biZxseg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781654776; c=relaxed/simple;
	bh=fkrCmopnIb13ipuEWVakk/KrAFvH7xz7xKtU4zl9YnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyXBamtO/fN5Ev182OcKakpaXYF0/fG1H+UpQn5okYc6yjTMCUDvBPv0LSMH3aAbIVxP4m3WIg9sIiejLmUXAQbEvQuyjNbwzv1v8PBdue7aj408zfYrzOGunt2UB6eNnxJN9DjmqTuROxE2brcmBWfhwQc3wjleBDI4rwzrLuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyKfVvUQ; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyKfVvUQ"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bc871ecdfso666138eec.1
        for <linux-arch@vger.kernel.org>; Tue, 16 Jun 2026 17:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781654773; cv=none;
        d=google.com; s=arc-20240605;
        b=HjOZ7FMf4OMNJLBVxoIGYuzucL6q2F4goVTIyattgtVzYJMNBRPyQID1bYFWATm8Fs
         xvkDlz+DN+41VTHIaaj5JL/7WglZIq3UQrNOnXR6M+hI0v9rul6VELeni+oeNGh37B9g
         e+2JUkzXKzfUAHG0Tj3TPWaDCtKVCkO27TQ2Xwlm7ntm0xMrU4m7opRdow5hbdbwQuyk
         /6LqD7eYG0eVbY9WV1qEngt2nZLS+ZsZFegVg72FtEMdMF5+GFm9R0jJDXrDuqTswzPI
         lL4YPZ19JwWPkWiOzO6r06Zq8Ddsshlqm6sa7H7PuKwZJArslmOchsS/xJF1a7nizrOG
         0A7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        fh=XR1aQvyhtria1vGC+VwYyyUsD2asUNL285f/ZZJx/sE=;
        b=kogdj74ssltUP4PfjropDlhO3CwxeQmU5vnhSjr0zR8qJtWIls/DK/MT68u8pJMxmX
         A7o/FPyysqDRJi/myKAsYmqkeI1ylJ40/bX3wqxiQXV5/LDfQH4lQjDkNeq/gKp9NWRF
         dLGA6B2Ih4SFWx9lSLWII1GX7qQKCMfx+6NLZi37r9WPeeOpRxLmd+iGEJkuc3HOAqVw
         ohm4fPUreA8MojzdXu288Hz+oBILO14kiIm546U6v1NZiBcDgMUQ+opnEaA+RBd2zuw/
         Nz01SrT/sqjOPd6zhnsOsMOLk3aTJSyZwMWlNBu6JSMYvyqid0zJVYei4PadAYOyZ1Mf
         Tu4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781654773; x=1782259573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        b=VyKfVvUQXBCvLPemoQfZAR1bpev/sXFbiYLvZNnkHW2QBnUmfUW5+EnR4H82tLJ5mQ
         fbIQrNhDToKOI5DMRmP4+w7EMro+mYGuAIjLLKP9Lzn3BfdQXT8za5DyMs30k5w653om
         XFNNEfczuDqsfD5hbSGTrtsSYddnbJUa4K7C4jvMEM8XSaE+n2lJ2mgjTlg98ILI/z76
         5t/97QXRzCQrAYGq/eN2YsAu909DuCkIu8zcIYY7nQBlK3P3EbeJa+Rby+lsQstVqhGe
         s/lv8vyKhwQXfYlfGqAo27FN2SyY3wnxyRwRJJSeHt0qUK6RDEP9lV/IulWvAMzMpe4T
         B7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781654773; x=1782259573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN2+45z8RuYVOYkmuHkDGfc4Yz20/+fHvo1TnYpToEo=;
        b=qq2lfBoQGIlOkbMFaLvDVYbTrOReiVF/zL4fPnpeuDcgMeYxC/toNCAWtaBpD3Bu1P
         ft0XrRsPfvb7d4gLaOpMJ8QQ5W1MP5+ZmnNSnvuoldKVlWydQlwsR5KzVD2BeKJJqzXQ
         WkiiZBxRUIDO+VceCiECG2ZoPyPfb/xKXY+wqt13B3T8h4pxe28vliaPhkSjWSFBHzkX
         F+gtgzQut/rFlGxiXCGG/0Pv9v8n4kFnhUFZTMWQKgu8BIMh2eJ2Og2qSmfozEhoW42M
         qLUooJkpW7A7sVvtss/pxPlYaIQpzw5xYg6KwdM1wZU4dc7d0XhGt94h1Jr1onDIHYXJ
         FrKg==
X-Forwarded-Encrypted: i=1; AFNElJ8oamOVYguGDZMOPEr17C152FLqfTDs5ugvy/9aWd0ObfR5pZaEDKSQDO6ucJ96wE3lwHTsttovWrTl@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrFVf/Vq281txnS7J3QMd9PG4VTxd1HaFeotjzaHQH1wMbkFN
	lwWFL8uURm/O74F8K0EdfMbKuZqdQghbU5aPFEqbaQzh0sdXL0P0360bcafxUbwClVrhNpT/Qf8
	wPb0bvie6Z71BbJ0g59IJLPeuBuUyo0r4lye4a2Rd
X-Gm-Gg: AfdE7clG+LNlTG5pKa7svtsyzplIlftZ3SU9j82gxtcLzAx5E28p+SZ3I8hpXF/RQDR
	7mEKHIq5+8JhHPBp+NJUu8//DsdRti61DC7gNqWpbBpzFADI9vCXc8c88mzsQ2nI/b2IR11CpqP
	DEKbZGuk43f0F8uvlllmSdoKyFsKRkFk252oQp01Gnq5zSHhi69MsvuWaXHpbyrR9M24oXsMr2a
	uA1geobw+CUpkcCkkBHwZagqJMlqyFPSndk52e7JRla6fRFzULPV4NvllFndEtmt+tNZnXfG/Um
	lpWdsbVe4JVmriI0uyYUeyj8+0zYmvljtd7yDb+vvitCQeVnLimKmBe6oOmgsvhs5DqNj0+D0lp
	LKFQ4MGqsNz/T2M2Go1XCKBrz4oGa4VztblukOfIy5pGznSn1
X-Received: by 2002:a05:7300:6917:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-30bc992c59cmr985150eec.5.1781654772212; Tue, 16 Jun 2026
 17:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616143020.3458085-1-jkoolstra@xs4all.nl> <20260616143020.3458085-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260616143020.3458085-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Jun 2026 17:06:01 -0700
X-Gm-Features: AVVi8Cce5oIkQ6o0SM96_tTZrEuKWAAnxCW1BPbsireeIZuVvbRqCN_usM_TBAY
Message-ID: <CAAVpQUDqPsRXdsW31prBCDart-LGsF2EmFVN31gB3Nx6WPT2kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: af_unix: Useful handling of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 7:29=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
>
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot.
>
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm=
-denials-on-scm_rights
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/file.c                         | 48 ++++++++++++++++++++-----------
>  include/linux/file.h              |  2 ++
>  include/net/af_unix.h             |  1 +

net-next is closed during the merge window, so please repost after that.

a few comments: please

* add cover letter
* separate fs/ and net/ changes
* do not touch tools/testing/selftest/Makefile
* use kselftest_harness.h and system()
* check other local rules (reverse xmas tree order, etc) in
Documentation/process/maintainer-netdev.rst

---
pw-bot: cr
