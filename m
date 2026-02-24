Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C60207A20
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898675; cv=none; b=QAe4NnbjphS3INK2rPegYWCMtCfJTqiDCVLjo5cFvdF6zS/u6mgUlIJNuy7ipL3k1oiAJh8JFRz+vqNelNNjJNDKTnd8yJXArBks4fFZubbn0vx+cIk0BzYbrQz1kuEHeL5MS3f6OghzI6KbXauhdvowfmAETzqqjV35qoBSp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898675; c=relaxed/simple;
	bh=4w3Y6h6W/nEug5ZtJazWCcCNYp3XbGkU9id86vGZAr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+nPwyTMkmS15jL4AYcLboq00iIJ1KY3MQGkbpAP92wpe3t3bM06enrOV+4rKsrjiDwG8faG1WcBmpBh0UcgNrpBqQZ6S7YmzjF8O2HM+zfeLYWHY3q4stoVnDD2qFTdOSo20ZUFmXK0870niFG43ebgzzmZNDj4DYajw0F+HYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhqdbTKY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhqdbTKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF89AC2BC9E
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 02:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771898674;
	bh=4w3Y6h6W/nEug5ZtJazWCcCNYp3XbGkU9id86vGZAr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZhqdbTKYf9yqS5bWH+Dc2fO1rY9aGLwLkIfpSMU+QtvPXFajx/aCScsRwRQqrIWA5
	 zcVLZkUFDWe1HwFfdBwbXQcko4hQ84stiUJbQmf0W6OHuU94eQnDfnxiYZhuvUbx/n
	 lKo2ErjcJtDV5XY7OwY0hrL18YwdMFPSFPRFZ8jn+efG1+BxrhRSkacmEezXwFyw0x
	 7xYa0C2hVfSa194JIkBb8jsVcRs5/egb0xqE7HIyBbymHv9hiHgFUAEdhdZtnHUfPX
	 jCzQwfcaWAo/N4IIxBCikZ4Is+dMujBnaeWSgl1Eiz/AMr968vNukG+5LOT6gN+PqO
	 f7wIdf4w6tsCw==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359249bbacso3592883f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 18:04:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnavdkaGl59j14QW6FGgwkQVxSL7bk+wC1qXXR9KqBDnqrxAMCQEZ7XYUE4ONWJbSatGNBrfTxIrcG@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcHDh3Ape4vzNfrIjJfKzEndwwuEQgdPvvjc4d6Jcgvous5mX
	cGgOzFKUw6MUFPy220Jk8Gc+Va5+MS1qFPByQkigiS3e7mRvcySytm8BCLbwQcdLsPAXOv71q6y
	h1JE/ff0QzjoDUGLSbuHygt24yDPPFgw=
X-Received: by 2002:a05:6000:2384:b0:437:6906:822e with SMTP id
 ffacd0b85a97d-4396ffdf811mr19610869f8f.28.1771898673371; Mon, 23 Feb 2026
 18:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125063941.443777-1-guoren@kernel.org> <aZbEGsqXSQzORQ__@pie>
In-Reply-To: <aZbEGsqXSQzORQ__@pie>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 24 Feb 2026 10:04:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQbjDnx_cBEw_3BD9Pezxn3tgX4EZG5P1j_viy+Yg5U+g@mail.gmail.com>
X-Gm-Features: AaiRm53SP5LO-pCuN9qqvurpHSrZAMU1NdkbxBfhDXWz0QDj4-paXiSeyyh7Xa8
Message-ID: <CAJF2gTQbjDnx_cBEw_3BD9Pezxn3tgX4EZG5P1j_viy+Yg5U+g@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
To: Yao Zi <me@ziyao.cc>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr, 
	leobras@redhat.com, djordje.todorovic@htecgroup.com, 
	aleksa.paunovic@htecgroup.com, arnd@arndb.de, rabenda.cn@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 4:05=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Sun, Jan 25, 2026 at 01:39:41AM -0500, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > The early version of XuanTie C910 core has a store merge buffer
> > delay problem. The store merge buffer could improve the store queue
> > performance by merging multi-store requests, but when there are not
> > continued store requests, the prior single store request would be
> > waiting in the store queue for a long time. That would cause
> > significant problems for communication between multi-cores. This
> > problem was found on sg2042 & th1520 platforms with the qspinlock
> > lock torture test.
> >
> > So appending a fence w.o could immediately flush the store merge
> > buffer and let other cores see the write result.
> >
> > This will apply the WRITE_ONCE errata to handle the non-standard
> > behavior via appending a fence w.o instruction for WRITE_ONCE().
> >
> > This problem is only observed on the sg2042 hardware platform by
> > running the lock_torture test program for half an hour. The problem
> > was not found in the user space application, because interrupt can
> > break the livelock.
> >
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > Tested-by: Han Gao <gaohan@iscas.ac.cn>
> > Cc: Yao Zi <me@ziyao.cc>
> > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Cc: Paul Walmsley <pjw@kernel.org>
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>
> With the patch, I've run heavy multi-core compilation load on SG2042 for
> more than 12 hours, and observed no stability issues.
>
> Tested-by: Yao Zi <me@ziyao.cc>

Thx for the Tested-by, hope this patch could be adopted.

--=20
Best Regards
 Guo Ren
