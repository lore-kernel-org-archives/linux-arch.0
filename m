Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7B4A2E2E
	for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370280; cv=none; b=sl9kTebBBi37tC4ky+GkiqxS5OM8njRrJLNBRD2ziGAxEyw69WSUNWy5wJtedS/9tKkMmfHFe9Oi1Lgcj9PcSOv4MS08fDt4AvYefrCyeuhGbX5g72g3DAL/qDtfcxXMPi+Cq+5xK+/p+iktzhoQlKgLe5rNqm95A3/BsMy1eYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370280; c=relaxed/simple;
	bh=tUvTRzVcNc49ZvK3Xd4e3G3ohTQ2V8/eGQTEBw6pJ40=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=buC4pLiSNCal/YBoen8vHwESpAqa2EZfRt7alRn8KaxCS0UTgeTN5LMU44rP02PXnwKJkLOvoCps42gCBb/oxBSg3RlTemg6TV02WDNkc57XsC83f9w2ZU7UPymE51IoFxaK54Po9Fw+5V86k0jro06yEP+AoSpry50rI1e/+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=luxpz+JK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpBVawMx; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="luxpz+JK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpBVawMx"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id D6A83EC03BF
	for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2026 06:50:45 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 07 Oct 2026 06:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791370242;
	 x=1791456642; bh=tUvTRzVcNc49ZvK3Xd4e3G3ohTQ2V8/eGQTEBw6pJ40=; b=
	luxpz+JK/so1T4nu5eVbt+zi5bbCWMXh7XfVsjY+pEIkTmttnuG2eHDakOcyI1hS
	5OS3e5I4EiWEq5pWFubWi83IOGZhIPLLupLiyPbggpB/r1LxNuoTJsnosIfN0spj
	yIvXLpQ9GS5/b486K0wRIXIGEolat52MujsVWStlbKxm8bTf30StkHHj/knj9Kp7
	w8AO5gFkEH6nv2a2jU/OA2PUGUzXsIAjzexWD6OjnCBcW3w22FSnKCmapmWnuL6g
	D6Us7/tmpJgGSSQho3BvLTa9KB4ZWI+zEg5pSU4Z18zPp/EzNUw6zI2dYe+yBljc
	sZ1mQGY97s/3PPqJCQwAGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791370242; x=
	1791456642; bh=tUvTRzVcNc49ZvK3Xd4e3G3ohTQ2V8/eGQTEBw6pJ40=; b=B
	pBVawMxj7pQn0MOAGXjomdjs4Upd0nXrOLr2Xw6e327Dq43F9G8w5nGB6vjrGPuf
	IS1nMz/dTpK7E8Z5HM3mkySkEl+XAUW805eYmGK42dMtr6gSF2KauNll2ZB9MmHI
	NIq/no/AP0s6pLsObf2HtGzFbJEM8wY67VAKM+uLgSffbxECf5ny/2l4B9xKUdA+
	6zlBlT7+FosxJ77oUHMkdgszH4FAyHVaCAYZpCGm9VMAnhqow7Jvg/BPtjsuh+lz
	nmlZBQg8wePjhl44FwOq74othf9oAvvqXkk1aoba8Yt+M6cPSmEEv9EcVKrrZB8S
	sZJgIufs/3+RVLxElOHbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791370242; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:iL3a7I9inS84ovJhnKhZxiCfe0H+9kxQd7CxuDYYv2iUHTX
	XWa3lLsgI1RJJ4p8+VttGZnoq7jbf4rV7OZEEB2KZFrpPUMoahC0VQ2IPOX8E5j8
	AFEv4nb4Cf4OBs+ydTUOIfsVpi1BvePYOKuN5Jb6yFGmNtOmrHwA95AUhGHbpNDL
	CQWSQRKlfC+PAvFaMoCJyNWM+NYlPAaa3aWf3y+5fEiiJZpCf62+TCuR2RLm7QEd
	ZFQnvuSzKtv6sQVrE9t3YoO+CWhrAMxnrmGt/v9rYImVStryyytrvKn0pg6Aq8JD
	B565EDSOarPJc1di8cUlpArDJH8FlYnuwlCLpPQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nd24rqhvMwr6YzhdLjP9PgBHBvlm6O2Q6PbWisaeCY4=:tUvTRzVcNc49ZvK3Xd4e3G3ohTQ2V8/eGQTEBw6pJ40=;
X-ME-Sender: <xms:_yPGatu7HrdFc6uxI1K-ZwjUIsEx59CiUXODR-AweqoAvTJsieAGZg>
    <xme:_yPGahSST4h6fmscfkV81xV4YxKGAD57U1TmYZNDXRsrXY9isk3zfuThUtn3LkQUl
    O8p05otqlpBw7KyWqC3HulwEM1YgfvkqhFT5wfGEUVkkKB3m_ibB6g>
X-ME-Proxy-Cause: dmFkZTGRqXlOKiOoDNay6f9ANtWsHoTGY+XwXgCCKh9gl3enreMC84wkqMt99EzViSemkP
    f5ODRap5IDJUixiJdxjgKS1q8T+wTFM4ZKUK8Ym2GdQa+ZzJWidwn0WVVRzf8mAK0rRLim
    DN3+sSy4M3BCbOagBm90WzMDH/p41rnf9QH7x4VHabUq/pN0qo1wPwsILS+Ggbn7Lko7I5
    WnpKUE4mRZIcYGd5xYzbr9n4apO6jh7PyhucM3qwYQKJBp59KOPtJZ+4b+cn3mF3FPJPZy
    Y8VbmbX43AkBSHFMt+fxNmlHXVFDp+PV1frtvEINe3dHG6zmd7DCzzkd2x6O+NTblPt5tP
    NbPea+Fn4c85gW8592lRLC1KYTG10wbsSyu8v4KNUsqiz+dpnR+6TWfTPSfFL98in2k1qH
    cnDS95RvWknhOVUccMvy7Tc7HFtQly5KuxdIwXeTcUnlIvNgGeumq18/gxdzp4NnY47SQc
    H56ufF9wPjRTMgN1Jve3uY0mjPNpmQUIaha/vzoLWKbaQLMuMXmDlRcDnHRB0t51XUkO4+
    LJ6tHiTITG3O4OnKW8ChQ/wg3jgZdzFO05ePlx+PoTApBBXvsk8WLwZpy5fGsQQlW7jd7f
    dae/G+MvGK6MNVp5YN1phNQdVGHmewdLXB+813nh3rJcN6GOCc0ca/OoDYzg
X-ME-Proxy: <xmx:ACTGahOpBMJGAKDZ5a-BeysouPXRJgxeDkR0coSpRrbVUA-zAQMxFA>
    <xmx:ACTGav8MHwSXI-fA_-GbGx2A4mxmmR2nvdvpjE364MppycIyAB4gaQ>
    <xmx:ACTGaifzvEaaYiiwuVStMMCGpj7OcYDpLXh2RPgZwA5Jtq1CvYreiA>
    <xmx:ACTGauxxkA3eodhaHcg_tfrv7CdrcZz3XO9BQ4QCKJTItJqZOdC4rg>
    <xmx:AiTGarX01y-UF7xY2LNEQPV_1PlP1OEtWdx3TEb5zTD2XbNEBREEE34a>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 79C8132A0093; Wed,  7 Oct 2026 06:50:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2-lVq8nTGlc
Date: Wed, 07 Oct 2026 12:50:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kunwu Chan" <kunwu.chan@gmail.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Ingo Molnar" <mingo@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>
Message-Id: <66d8d340-ff50-4fcb-bf19-05fa68c27238@app.fastmail.com>
In-Reply-To: <20261007022859.60101-2-kunwu.chan@gmail.com>
References: <20261007022859.60101-1-kunwu.chan@gmail.com>
 <20261007022859.60101-2-kunwu.chan@gmail.com>
Subject: Re: [PATCH v3 1/2] rwonce: Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 7, 2026, at 04:28, Kunwu Chan wrote:
> Per-CPU variables are sometimes accessed from different execution
> contexts on the same CPU, typically task context and an interrupt or
> NMI handler.
>
> A plain READ_ONCE() or WRITE_ONCE() marks such an access as an
> intentional race but does not express where the racing accesses are
> expected to come from. This distinction allows concurrency tools such
> as KCSAN to tell an intentional same-CPU context race apart from an
> access that may race across CPUs.
>
> Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() to identify accesses
> to a per-CPU variable which are intended to race only with accesses
> from other execution contexts on the same CPU. For now, they are
> simple wrappers around READ_ONCE() and WRITE_ONCE(), so generated code
> and tool behaviour are unchanged.
>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

No objections here, but since I missed the background, I don't
see what a future implementation of the new macros might do
that is different from the existing macros, maybe you can still
clarify that.

For taking this through something other than my asm-generic tree:

Acked-by: Arnd Bergmann <arnd@arndb.de>
