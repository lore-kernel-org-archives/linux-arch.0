Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811386;
	b=kSnURJSvj/Ij5PKP2S12/4n15VE9+XEa4VqIAqsLo8ibmTYTCfBQdwjQLDinweFTnr73
	 rmz1SyWbR8rmq8TOm977vl+fpLOd0lxh0NLxoFFNqob+ekLzOo+pXNQr0Mv4j9EKUYj/C
	 GB15Ja3LTBNwVj5s+6Jft2PDx303u2eCJ6wejc5+R4xskT82/QWjeAjKSN7xnqL8m5Din
	 IgggNDwL9FGY9PlDlNCGtzVAQGAuvdRjjlShDm2pK/tX/vJGsk1KbBf4pDV1FfV3wy0Q1
	 yVSE257JBdrSNFugvkfq3+5CFWFlAWv/o0ErNuFMFhxDYxeHmxBIwha/uJw77xfJObg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UXmgooCun45H9nlbuiuwQFHR9S540n6oe4h3LrE1mlU=;
	b=XwYyd3JSnRgKxAKHQAh1mVZt9SL7ybaA7I6XV7rJTQd5yyi46a2T2RTimp1l6pdTxNP1
	 MrVKSz3UohkP+QrgIeca5ao6ODa4MhKkdxx4N4zOgsFqfZ7p/w133DgvBKlQxYMxjEm6o
	 gforHfIYPhpgSt5nRFAqKkJndO3mktPnCju9EKwe0QtH9u2d9i64oh8YURAtK9XXkbGiW
	 aHpyTwu7e8XJw0FJACTxlvMVk0ch6aQHrDaEkq9XeBKCqYZHfHCSFKs1MF3MB0QDfV/7h
	 ydS/Bgwklwu9wfeXJG/j2q4OfdbZXsGm4eQYXlLjidM8ChkM+HyDLmFb5GWgttySG7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ds9ImoNF;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9E606A32F
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC9E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ds9ImoNF
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so1761921eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811385; x=1794416185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXmgooCun45H9nlbuiuwQFHR9S540n6oe4h3LrE1mlU=;
        b=Ds9ImoNFnqIw6Qw1Xrge8SkX9ej0FZa29MRVRM8wFsA0dQhuXWwqhtoYP7h4kad5e+
         CujAQIMvVoW8e/ktVA4RJkhE4uKZXGsISnstiGMOLDEmO9nifwT/0JQRpt004gFRJZka
         aEN6hIa6lRyLDyjswYqiyD8FDsS/G+5MA7geCMPJHINQ1V8ZqZdDIveb0rMC984y8KI3
         eR95uJTOaQOkLl/fbaGQHrdaL5TBwFQZNwuQsEHOhhRuT4aizhsDX+zooDipclNZN4so
         bW+qgoLjH1gb/KVmb6CxV62RY4uS8XAiAEaBZKn2+qXwuceGSXYh9D9dKoNtagpVAIhu
         D+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811385; x=1794416185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXmgooCun45H9nlbuiuwQFHR9S540n6oe4h3LrE1mlU=;
        b=zqBnetpjprPKjHaOL9ccUd4vlSY+0nkxUc71NHM0Sry76rDbQj8u+LrQ0gdMaHROhs
         wTRaVBUyoS69bqXgtotSqZtGnckuVF6dal21/RcvHOILrWv1vfGgPYYjJ2USV4qw7qjc
         FbhU8i2KRow5vLgMUQh/NE5pXxFDpwRijcI/DQtZu9M4aBkv/cPZAQHOFTmxuu4KCL2Z
         oJF4SqiH+6m71RfAe1sf58f7shhKFBRnLPVPbLwBsInt0zp5QIYTxcTrKUG09/HJYJbd
         iWUry6kzIPBIzkl8DcXyEgbS24JQpv48UcgC7cWA2np308gQwcs9pvrt1yiX4gQ+QOfQ
         4ERw==
X-Forwarded-Encrypted: i=1; AKwUvByVrOpbOn4qqPszV7j2Wj6IXR0PTL7GmiR/vaxO+WAg/kOVXX/1c983S3Cf6dVneFOZDS/o44rPNBDk@vger.kernel.org
X-Gm-Message-State: APuU4Z9YFcg4dySppEqxO51PrzrlEhBOrkoRnwgV2tUgeNTT7P3wn/Oj
	8oyPH3WGInbLjUgZS9efE3a75hA1NTVtQcShEo6U2mayASesOvns9ZYz
X-Gm-Gg: AYBFou3IFhPR6Xv0eKV+u3WiKfXK/hQMq7GBPneLFnaPzWTKSzH8BltVa3blTSSTB24
	i/sWf8P66VX9HIJfTrQ8MVjy/anawZxcblntjbAR+axDApJSR7Csij+hMU3gfkWOkO77r7cKrrV
	LPJCczdBz/jKnNHizlKZbcrVwqhyON7vE7yCAMEimuI1sVntBz5/xLKC1X3mzcbs0sHO5FAJBwy
	fh3QSCj0P+8xy3WGtjTeB2U29Vp12Qyep21w7a+NE00FRsW8z+8D008yLI36e8bDlsSHqDyYG+2
	7WTfLvKVzBbjVnU1kGEgMEt38cawIcPTqwz5VH1FxYLvG3c0ar6FnlR9c8yEXuKxLG0zZYYYyMP
	jaPwTvJUq2H316FYGBvzsGjLp2HL5NIfHiy70cLfPOQsehPpS/le0C1JNnHujnLs5rpr4pYkS2B
	VdxALnhHdQ9YAPuJRINywuZzrv7UXxS9WVDu5VWFrk/rxvGr/GoRR6TppgSgaR0CZ8Wm2Owm/sM
	9VI8/TBTCGXRjKz8SPYdv59avStHpcxm1RvyDZNEjwei/OlcirAiQ0qU1WsMX0m66nvDdyqul3j
	o0cAgXgCQsLzUfeh2//ZKfWY/RI7opkzFQ6+9+o=
X-Received: by 2002:a05:7301:3d06:b0:358:eccb:af7c with SMTP id 5a478bee46e88-36a42404840mr36237962eec.33.1793811384606;
        Wed, 04 Nov 2026 08:56:24 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:24 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 07/28] hazptr: Fix kernel-doc of hazptr_release()
Date: Thu,  5 Nov 2026 00:54:25 +0800
Message-ID: <20261104165504.2430480-8-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second parameter of hazptr_release() is named @addr, not
@addr_p.  It is the address passed to the matching
hazptr_acquire().

Fixes: 17969a0e7f7e ("hazptr: Upgrade kernel-doc headers")
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 include/linux/hazptr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 299ad8a07156..0fb48518525b 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -315,7 +315,7 @@ static inline void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr) { }
  * hazptr_release - Release the specified hazard pointer
  *
  * @ctx: The hazard-pointer context that was passed to hazptr_acquire().
- * @addr_p: The pointer that is to be hazard-pointer unprotected.
+ * @addr: The address passed to the matching hazptr_acquire().
  *
  * Release the protected hazard pointer recorded in @ctx.
  *
-- 
2.43.0

