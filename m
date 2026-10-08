Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CC3ADB92
	for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2026 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439028; cv=pass; b=mpQWPllAWT/jVNqFltrN2uojioCo1lnTZEUsM0DfpeKJJhZ6ri1x5SyGOaeXyuR4QaLAzaxxXAvpQW4XCuoMjPZ0K0J3b5riN81WjjtxHfXhkChO1bQlDuLtXf7eIaPrFXDhcBTuK3by7e9HVqZyLzSYtnxqON+mxUFDhVS9nSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439028; c=relaxed/simple;
	bh=ERFfEbPmweH1yhwx1o9jFMHg4vWGfaK55qTf8oHXD5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXiJsZZe9rw2FxNKKQ79BV/ihNeAkSabmaMWreOS+rS+GNQu8ydhGuFahGi0TzOonPvEE8lb2vjAmSCbtd8K36jGsFalB5EDnX4COHAfegQAGTTNapqiEgSMubY4kxZEAHwGhHpqaj79k0RzWTaBFkeBNVC9oCcdM7+NrekDNik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7jWfO2w; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7jWfO2w"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a17f65ab8bso9717505e9.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Oct 2026 22:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791439025; cv=none;
        d=google.com; s=arc-20260327;
        b=bagNytHSVyJms25j/IYQWO7yIqPc9MF04mR9EruSd0nFKRertntQs+ptGMcSz5023U
         zHBfinL4PPBSX/TB7b665BXQrTyS7zCk32JtSYSnId3FINtjo7sYyTaCaRoYZ6fhcPsa
         u9+DL2erh0D2faYhvMQFcS8NCQxU7JnErudKrlz+GiOfhI5TPtmgA/EWjJNjnQwHXdl4
         357QpPkq6/96ETO8G4T+kyChN8z6mYXYYLYfwY1JZRxVbvGSyLA/5m2iQyXPLfeZbbmY
         IBWCjNitPMhql/vn5o9sTVNU1Zqq/warkcHy43ZS/NmtEJSVGCLPKgmru5LdDuHhT/Ai
         m67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ERFfEbPmweH1yhwx1o9jFMHg4vWGfaK55qTf8oHXD5c=;
        fh=AvlNxjwFsLAqIIQHmAsUOTExfhbp6IFh295f7LmmcZQ=;
        b=I8PvZXHeKW1CLIut5jH8slz3oWy4O45miV2/MzMg/JiE8GXEODWB/Bh5N1i44IMVm2
         Gaunx1tJ9l3s7L+OLYWbTVZhqDwfZZVUNIuioXktfF8JiXOF98GNrXTR/EOElJPPbkqR
         6KdRS+i6BCxL8KnqlclctwiNORD2hB1oPGUGBeQ2aip+FAs3dPNL2gds7eTIupGC/Tzw
         V2/h2sTQEKLUhOBoO8hKj32XSTob0ZpaeGNilQy7fe5kgJwnNCatHGRT55AAL2p8vRtk
         0UQq6NMz+rRjQXsv7X6EZOGDSEfyH49BAB1XPMBt8cL2lcD+NTqThZ+Q4bqQsY19JN/V
         c6AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791439025; x=1792043825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ERFfEbPmweH1yhwx1o9jFMHg4vWGfaK55qTf8oHXD5c=;
        b=O7jWfO2wQ2Z7PQKVTg99P/xL2e3XNZui+kUjW9f+5XC5YmjWcE+Tywkr9Wof9pyOie
         iFQYJiHtCq9ZtU1LEq9Rid/9CIbeLK+B5gMxy3tSeWH4x1JX02jsTl8Mukj/KLgNGI9K
         V5reynBN4+InU23lD6VbcY109EWQmZtGfsgrgsLUPjtbsLlL0RdYg+gIRbAHaanTPXoK
         CSCBtrVobLe5ykdM2vv40IRNamVADdMOG6oB/De6+QUy5mSysQklLV2WhG/mUh51eOeA
         lNVS2yeC1etk9cG0SgnMFzdtRlWepmKuG/HMtKt/c3+j+9E1R9iu77N5IMHkQ8wAc0k/
         gOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791439025; x=1792043825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ERFfEbPmweH1yhwx1o9jFMHg4vWGfaK55qTf8oHXD5c=;
        b=b7MWFv0QIKy1lRvFgO7OsKixhh2MnRF3C+sVwDWZL6tio9kB2qtHJPy5uzFEzDQluP
         1tb9p6xsRIdeNbdsui9mcl8rbGvRcUMTwP64BdLIq+UbJTrUMgGynklDzfN/4Rwjsy2X
         C5W1AoZySqGhUdSCVb36NInwtsQF0mMEOAEi5jrSZdeDdf1kcSyKsdna/YZF0PbyimOl
         KbCxdDy5lot3QWeDH9Hjkcv0vLwdSXtTQ7yCl2NFdDH0puKl7/HnUFU+H1nnJjvJ7WZ8
         tH2lVZk2Qb1i8PGU+lBxXI5po4cAKnTEF2Dx2XEteUcWs8A6Ad9MxNxGLCUGZNrbDmbv
         bD9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwCPvIhXodLQh/Aalvil+AvHdLn7WApfKeXGkqKQ/Cpyb8Mhd7xo03gJsZmSofwZk38zd80c+pLhKMu@vger.kernel.org
X-Gm-Message-State: AFuF++mfExaM/zl2HP+sc/wOc3OrUTPFsnW+rPv9EBrWT/flGLOs+uh5
	sUrnkDALQ7FGw8CTdwvcOjFXs6jE344qTrrWSlyjLdp4WY87iNjUEgO9AB3RZ38Wn4amwTdoLpM
	b4oYtTLSKnxkPl5INKlg5kHdP6feESIo=
X-Gm-Gg: AYBFou08qdVUcFGAbQfPKAljZr3zqitmaG8MRjdoPswxQUTpdgn1lYf3wv1j4Q1KUdW
	qLISHZroCegH4o57ihspW1xAHPiev7Lm744FPR0MJKQ+vYHBHxmo9YupMCQkpMVtvZs0BXltbzA
	jdek/uI7OE8/JTmje2onHZFQD6VUaUG9F9W80f9A6wgTtUFdD0QHxUVvoDzbyujmXRro4ACybqx
	nygQkaBFS//wKAXC0uH+RKtjA5fP5TpLO6jLG8/xpq72bwxC9JQOrKZjdjenZw4SMMeyOeoAkih
	Yal930eGyZUCxvKcTTRMbZJDc4S5mm08LFD/o0K9GE1bjJjRzxP5vhto
X-Received: by 2002:a05:600c:4fcb:b0:4a1:7b53:c8c4 with SMTP id
 5b1f17b1804b1-4a180455cb9mr75121655e9.27.1791439024920; Wed, 07 Oct 2026
 22:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007022859.60101-1-kunwu.chan@gmail.com> <20261007022859.60101-2-kunwu.chan@gmail.com>
 <66d8d340-ff50-4fcb-bf19-05fa68c27238@app.fastmail.com>
In-Reply-To: <66d8d340-ff50-4fcb-bf19-05fa68c27238@app.fastmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 8 Oct 2026 13:56:53 +0800
X-Gm-Features: AclHuK_vneNVObOeVywJe48WggHU4Sw7QcVGazKvBlLRarryICjDBJz7-XGqNn0
Message-ID: <CAN_Opa_7iaGj0_=POskHU_KXqfDUbJiar0sPj8dhKLf9Cv2riA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rwonce: Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:50=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 7, 2026, at 04:28, Kunwu Chan wrote:
> > Per-CPU variables are sometimes accessed from different execution
> > contexts on the same CPU, typically task context and an interrupt or
> > NMI handler.
> >
> > A plain READ_ONCE() or WRITE_ONCE() marks such an access as an
> > intentional race but does not express where the racing accesses are
> > expected to come from. This distinction allows concurrency tools such
> > as KCSAN to tell an intentional same-CPU context race apart from an
> > access that may race across CPUs.
> >
> > Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() to identify accesses
> > to a per-CPU variable which are intended to race only with accesses
> > from other execution contexts on the same CPU. For now, they are
> > simple wrappers around READ_ONCE() and WRITE_ONCE(), so generated code
> > and tool behaviour are unchanged.
> >
> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> No objections here, but since I missed the background, I don't
> see what a future implementation of the new macros might do
> that is different from the existing macros, maybe you can still
> clarify that.
>
Hi Arnd,

Thanks for the Ack!

The background was discussed in the v1 thread:
https://lore.kernel.org/all/87qzici6yb.ffs@fw13/

The idea is that the *_THIS_CPU() variants make the intended
access scope explicit: a race between different execution contexts
on the same CPU, rather than a race that may occur across CPUs.

For now, they are just wrappers around READ_ONCE() and
WRITE_ONCE(), as Thomas suggested. A future KCSAN implementation
could use the annotation to distinguish these same-CPU races from
cross-CPU races.

Thanks,
Kunwu

> For taking this through something other than my asm-generic tree:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
