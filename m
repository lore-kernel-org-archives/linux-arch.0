Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811570;
	b=lAXAlaneF98ZZ06JlUfCODZZjr34tXHiAU8JcaHN9ISSpYanM9aiKnHODcdY8huHXXuW
	 c0nHvDFE+4KSMdkiX9aSBDbZp7cNYWwc34bMVSWPtEVPcUz8X7pWorW++gjps9gfmFXyw
	 MnnuJvXaCyXsho6ZY7LJfFlmqqp75rHLuIVQWJOzLoKccAreGC2ixOq/6/QAsncxZaTlE
	 bJ2HRp60MbGQaNMFKZ9+G+/9KvXjN7P4+euB2KZ6I/2Wa00Xc1+lbxeOyyAqFD412RW1c
	 8A3bOZShWw6QqYWhxyZEv9bHqi4pBx5Y6eJmHTeSKRcy2A+R7/MDnxAmCwIk53gSS8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h2kyCpxYn7quzffs+glqhT99zkVyPPhwyZ9QmptjaK0=;
	b=uQHL84rHgbgzw7RNTzYjOCkDA/FlodpgviA8mXvKm1L5a0Sec6ezmxCvOHRAAXFXxXuk
	 a3GDB1cWVUSF7+Kk0PhUGLpZxp43n+gOKAxmpr5KOjlou25s5TRv3I95QcW4v5VB5emzd
	 j0COrBWMwLR9Z9hkp4SdkVBsEI3Cr7j2lPMdOrq27Ui73yO9gLjzNIg9Lnzq5RQyJnzeb
	 ZJ8CdXHE9K89HKswkjv4yMHclpfU+0jCGexjT6jRhoFeE4mO5R1DNz9Uxrw4Hi1wnayHp
	 HrJtyaNcz9TqIBP89O72pSM1MxH8H3Ljqcmttpu1AUat1YEyEL+AoA6MDJcSePLi3Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZdVTN83c;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108E606D814
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C108E606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZdVTN83c
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35c76e9614aso1211491eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811569; x=1794416369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2kyCpxYn7quzffs+glqhT99zkVyPPhwyZ9QmptjaK0=;
        b=ZdVTN83cZuFdJy3X+OheFWasrMSC6JUzg+o9axzkpEXkzy3ZcJgs+O7DUe4iW541rM
         8Qa2TjnoF/4+YdE0R4punsPO6vNtDfrsofSpoxTEi7f5bCWNJPqqWSvkmuXPdrUHiJBF
         zHJpQH0jKZN96FKPNP9q6mQpAjU5e0ltO8u+rTtLxq2Z2hd5g1rQMrg3MJFl9Jy9mcK3
         NE8JAvD7FJP/h9XT4k2XM+PHLse6YhNUNfTfxUbkt2g1ne0TSB51Z19KCLpaedla1UdG
         9rCjI5d6khFh/7SQHcVjcXGACkqIWV49AFM6/oYgeoFc2FAZ8l2/2021b2Ogs6DcC6V5
         GaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811569; x=1794416369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2kyCpxYn7quzffs+glqhT99zkVyPPhwyZ9QmptjaK0=;
        b=BXze8uIjLUps61ZhX0t+LvVRc+6Yvx+Jn/Fbp2jdxtCIQvTl/lRipwzaQykoEwdi1X
         0FnXVdTEYros8gBCBu6uW5J5F8s6TM4wMDa8F3Cj5HtLlmKRBm3vKQ3xpfu4t5ZOMF0M
         5Hv4KCNWR4mAILhwBm0uFqSP/oSCDwY0xuINju4CsYq7J88ZCjRtUs85CBugsIML/Ytl
         J4mVICZmn+Rm+vCDXugpVlK8YIPdVo5xceO0gy12/Vc5Gsrgo6MlAHY1mLmH6AGf2R/w
         hPS+0oolO3ThEbxvVs+72mi6UFLyrkl+XgOpNY3yTaoaRNK3IV/k6WNODxkNssJG6LGp
         h/Wg==
X-Forwarded-Encrypted: i=1; AKwUvBymMZm/JaQbPM9KK5a71V4fzn7m6cdsEJfiTHJB8wcyZ+Q9WjSQL/F3Kq72mP/jr8kkTZmhRXN+kzEA@vger.kernel.org
X-Gm-Message-State: APuU4Z8iBxJ738QyB3YEf/BJX+BzTQ6i+5NBWWnHUd9v/CWQimYMt2gG
	7ad6JaQ70S6GjMGiVXLOo4favSTj5dQ856c1V6MaTBPidHAaA5ePL71y
X-Gm-Gg: AYBFou1PB66L1Gz48eMPfJGj6bwRoYh0NKFIjancD4FHGi6isdzVeQ5T+hYqXsxTNzQ
	RuBGbx34qAXAyb0L0Vs1pvP6Ex1D3xhARWazCefG06hfGUQDKHDzzQKMUxo/V/wtCqoSuFynnYB
	aprpNtDRS0LoF3dOesjoblZTMM3ruvjYD5ZdJ7ILVx9g2nUQ7Mbrobl5MTfH6MRUSqdaUZN3cGd
	3t/ig9QJrADLR7tfEcKRJCaMS3wSQgKHVXD9BbA7SG0/fVUL6wxOMwvKFXOVQx3tH+1YWwnEea9
	BLTKuH+fmwvu+TnKWK0CB7cAUKjmBqsCnVsYQnG6SExzwnPVQfamNpqjnpNyp1fDSwR12E1ussY
	Tz4O5c54eD5Yer9oUxPPpjObgqAW+81X+zZrELagFF5HlWyVDG6Ui6OsRkkyBCYoI4kzet59BMD
	GH+FMMHAHYGM6vyoZfuH/P76X0mM/ZK2id/v5e098+pjiRm5sV6RSUVdaoko+dqCF1As0ojcvii
	x5/pzewNmtWu1N0qzzM8Y6S3L+TDHihkMKPrKGoW3iaCSahys5ZhBX7APX+ib34jR5cG0T+fOUX
	r3jLIx/DSHbTdw3jek8fkny/BjdkEL8Iq1z7398=
X-Received: by 2002:a05:7301:1a15:b0:369:a113:756f with SMTP id 5a478bee46e88-36a423f980emr22997970eec.34.1793811568303;
        Wed, 04 Nov 2026 08:59:28 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:27 -0800 (PST)
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
Subject: [PATCH 27/28] hazptr: Add Bloom false-positive exact-match fallback
Date: Thu,  5 Nov 2026 00:54:45 +0800
Message-ID: <20261104165504.2430480-28-kunwu.chan@gmail.com>
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

After 200+ scan cycles without progress, do an exact-match
per-address walk to determine whether the address is truly
present in any per-CPU or overflow-list slot.  If absent,
complete the waiter immediately.  A wildcard counts as present.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 66954251c332..13ae9eb26a8b 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -407,6 +407,7 @@ struct hazptr_waiter {
 #endif
 #ifdef CONFIG_HAZPTR_DRAIN_ASSIST
 	unsigned int drain_cycles;
+	unsigned int bloom_cycles;	/* cycles since last exact match */
 #endif
 };
 
@@ -852,6 +853,18 @@ static void hazptr_scan_do_cycle(void)
 
 	mutex_unlock(&hazptr_phase_lock);
 
+	/* Bloom-false-positive fallback */
+	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
+		w->bloom_cycles++;
+		if (w->bloom_cycles > 200) {
+			if (!hazptr_scan_walk(w->addr, NULL, NULL)) {
+				list_move(&w->node, &done);
+			} else {
+				w->bloom_cycles = 0;
+			}
+		}
+	}
+
 	list_for_each_entry_safe(w, n, &done, node) {
 		list_del_init(&w->node);
 		complete(&w->done);
-- 
2.43.0

