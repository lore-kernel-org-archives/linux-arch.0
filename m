Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114A47532E
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933089; cv=none; b=T21j0nf1h3hRB/tffZhWXL3hhqEBaQPnF+AvuFbzlYZGe94l1kGLpxHibgSN68AIZay1xhSW871PqjK8Wsx9G4H628OpPOwwIeKy0kea/SUbV1PhjoFdc4k6rbnVB7JX0U+Ebd3hIJeI/D47NcEeU4DlVvAAVl/fQXZJ070U2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933089; c=relaxed/simple;
	bh=vD3k0UChVcsUPV8WCpzl60xjcOJJ7AH4O6Kwg/ASCvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mao8YbMXa//ueoplO6UohbRN4j0ZXgKQmnRFshbdUZbKn5ZTlPcPSj9LOEfAMjzvzMhKFSKrFzAx4l3LnV3G7LZ1EACBrkW+tgY+hC+X6s7oGTu+L/ej3vfssZnc7Acj0o8TzrurMlRcu6xsaXWz28rIWjZbIfroMDq3sxpdsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RrlNGgY0; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RrlNGgY0"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66fded6b087so2183715d50.1
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933086; x=1790537886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xd0t5fQ0wbqovFneONezXRLopfuFSVDwWIsqSLQ6+6E=;
        b=RrlNGgY0iJCLHvLzaOqKkf3gLzRqZRNs3AAepRwIwDleyCYaiOghA4vqiXA6qubzC+
         24dvZefH6rJFbESqgiBexlht9k2P4jayHUVOxKavkv047Iwi3j68ZxrHzNYxx4AhE2Qb
         aKxGtjXjJX6+0Sgcy+nXo4muIMtbk+5iXSH83LreZrlNlj5brul3XvqxZuXYyMkJHbx2
         M9kE4SgGfjg/AgZJ+kZyRU2gcJRKIyvpm8ZE27VVSIw/faLLB90ylpqTLqx8w3sMAtH5
         fDGymuvYj2dE2L3f3IPD7SWIbaWLjxdGzXi9W7OVFRvoL20by8hHYOwrYpq+32pX2pRJ
         NpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933086; x=1790537886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Xd0t5fQ0wbqovFneONezXRLopfuFSVDwWIsqSLQ6+6E=;
        b=Pdx8PSayv0DefbgWC6P/RK8Fz81wLy0YE016SZHH5KRVtqwwFPKHJOU5XXbq3OkbQB
         TRKo/QS4YZYhB7H8UVaf5F4+e//PUhQMnTYu9isFjqFPhdUOFUkbeYzteN8kOR+t8UF8
         AG+TcIylfhIAYoKoDBdzncEVn5EgN6Io/sDBYVaDjKJW4ZMMxFwZMZ/C4nQk9m0OQVyW
         usuLCmgGapz7OSalzbWbD1D0iBM8XvqJkNzisArwWRBvXUoPxKv7jccG/yWOprWo+KDL
         MJyh7u5SHKaAZFuvAabKpSld8dff/gnaOBZNwpjBAPMQa/DbM9dJS8hzATgIeK7kuAI6
         OdTA==
X-Forwarded-Encrypted: i=1; AKwUvByJqrrzDpNVro5aTyMAE7zvdy2lHhlwHKz6aT2DBLlf+V95sSy5HBx8ZIpeAujm1juwTjHUzJwLs2PP@vger.kernel.org
X-Gm-Message-State: AFuF++k4F+vk+MJjpYeWr26ax5MuretPK4cDEV1Xxiuq7c68VFwuP729
	TKFvKOEJuLtnKwsJzB9kQVOnvwIyWglAG6aEGL0/gxmz4f0y8Ny0s/XtJFO3gvo4lbU=
X-Gm-Gg: AYBFou2aUc/lM34FDt0rONvneulVJrwjVN56HiFMjW6mAKZ99rEuAULhb4IAOmNh6BL
	SBeambPExWGFVaE939B9/c/lwe4Ji+S5DSjsxpN98yOXBGYoqa5ECZF4Whh7PHWv0cHPZJu04RE
	/S7zYMuppJxuIeKCP4EshuMtJp1kO72UwNlhgcc1rs6Q8mwtwfTNKZZkMPbP2IHbB3kGzmFMKRZ
	TuAOY2DeBLdpMOTA/0dACzc96/MB+OAybMjaFPp/MCQNAmSMgh4mWvYLwYl8TftUSzIHNXY8NU6
	dGQdkSSQSpHstHu4NJTBti0VBh/GgQpVBrkzJPIYK41VHILeBU3qvkfjg9aRmtbB1HR99yR5VkP
	Ld/KrR+MV1D8xPEhW0pcniqH61OzDny5Pszqc4InIbCAfp/1uqvyb/k1u4c0PHoZdALc/MKAGuk
	Wk5DpeyENTXYHpruu41vrsb/wH6PwGn2oygMx2kJ+wbIsdvoGR0I5dicKrv7qCqARDTiz/EAR7U
	qYvEyAPyK1kBI7ikDebiZTZ8167g4cOOS9laMfrX+cmEb6QiSN9XEl29kAfb6YXiKgYlPoDKmk4
	RLBp+FSxqxbQTB4G5kU=
X-Received: by 2002:a05:690e:dce:b0:66f:c1be:a646 with SMTP id 956f58d0204a3-6717fd8f1ddmr2788927d50.56.1789933086522;
        Sun, 20 Sep 2026 12:38:06 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672991445desm2614214d50.20.2026.09.20.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:06 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 12/46] liveupdate: Add liveupdate_session_name() helper
Date: Sun, 20 Sep 2026 15:36:16 -0400
Message-ID: <20260920193650.3373435-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an accessor function liveupdate_session_name() to retrieve the
name of a live update session from its session handle.

This allows kernel subsystems like CPU preservation to identify the
session managing preserved resources.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h      |  6 ++++++
 kernel/liveupdate/luo_session.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..119ad0f82705 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -256,6 +256,7 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 /* Get a token for an outgoing file, or -ENOENT if file is not preserved */
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp);
+const char *liveupdate_session_name(struct liveupdate_session *s);
 
 #else /* CONFIG_LIVEUPDATE */
 
@@ -321,5 +322,10 @@ static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 	return -EOPNOTSUPP;
 }
 
+static inline const char *liveupdate_session_name(struct liveupdate_session *s)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..3c4f195d375d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -683,3 +683,17 @@ int luo_session_serialize(void)
 
 	return err;
 }
+
+/**
+ * liveupdate_session_name - Get the name of a liveupdate session
+ * @s: Live update session pointer.
+ *
+ * Return: Pointer to session name string.
+ */
+const char *liveupdate_session_name(struct liveupdate_session *s)
+{
+	struct luo_session *session = (struct luo_session *)s;
+
+	return session->name;
+}
+EXPORT_SYMBOL_GPL(liveupdate_session_name);
-- 
2.55.0.1082.g2b9226bbc0-goog

