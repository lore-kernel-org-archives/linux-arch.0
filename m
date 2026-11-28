Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827354;
	b=3/TvpboTDDgMyNGnJUjEVQ7eL0J05aVA5bZeh/hxUIvUxJ172LDep4SnS3KBwvghGYXl
	 MeGAQ4Oek7WWY05VtTiafOC75wNed1cPxOZJf2TViFi4tT+e7l0hFMbSWoMZ4KkNeO9Q5
	 1JvwvXdysdW/xv0DpVtzX4e3CNdu3RQ4tsQfGQBP6+xLNg7scXYH4BNZnjy1vU4+O+d5Q
	 brkltLYeJlVzqoI2ppUnkV5xoi5O+CiuMrxHeXm+zSAmYHKaJSIF5zJprwkuPiJaRJ7Kv
	 FEUSsbEUnfyOR0HJZkRpuiUIps4vZQ2atviuvAbXB+0Zhufp7xhH9VHeDO+PHEyMG5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
	b=tadQFYvKPFOnIGTrDH3bCJCVbO93MdPPFmfPwixERFn7racHKb3CdwDMubX5aL7k4RoI
	 FpUw+Ti+nzH9YWrdoqrulg4nxWA9DBUa6vrDElq2SqnOT31Mc9Li9OHr56DvGXNHb6Uss
	 wk43Av4TdgcYIkHJrHrEUMgs6Ds+S1h/5xV3wuEJ3f24SJDWFqu7KlbeFVHoAJ7/WhOic
	 0HZMKhdZMWgiJGRrvM69114lA4dbYFGkldssm8fMtvENMVGunhCwUyYJcsheyi7FtezL/
	 kz/TIhY39VEQWx2YGTQjVUBUjsvpMZxg8J/lcpkHojyAwPQy1LFHs1nsv4TuahPOBaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC577606A323
	for <linux-arch@vger.kernel.org>; Sat, 28 Nov 2026 00:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC577606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bba60271d7so30672155e9.2
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795827352; x=1796432152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=egc5oRyUW6VFDIcdxYwZDeGVcRPdqVVcw0/9bUs8kD5ZsjJsFc0wc7Ij4lq+IUwayF
         w2XgNkLL/plAb0xjtXjWDmbgHsj8BbN8y5QH4zabvGdDwwb8xzCpvOiS/FFDQ1pAmNwA
         4uiU6YjDORB86waZuFacytNoIhdLmWlhX93TlunzFDHBxP1tk3JWqemA4JUyNxNFOtfh
         CKwdIz1EOzEmUqFvrYxqw/6yXUkip8rv4zUWrx4HDc3q++gCUskaW4sXZoxU4kXNS894
         nnM8O1l8kivUFX2WTqpxfjbMSvlGbzGIvqyGbP1cvEGn8taKbCLd436XionhZ+TbNkl7
         Tb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827352; x=1796432152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=qyyyyxfqwkETLD2qdtG3Rb7KzGrmDW6q8MinrYen2C6vhh1h5uErI7uS0RZt9KAXd5
         UIE63VRXJmLmN3tHJ1MblfHXBkw/mbEHGaBp1Ml1vlju8xi4t7CsPWWW3RxsBrlUcgnI
         rznPz/Mp803cOwbqEcqCAx6zDcYj6nvQrhmay/yIA1BKK6Gfogy2SIAr8YHdfLZvFLG8
         cJhiOkSUTusZqljPh13jnLAGyg6rVXmJfBDKbYIQkk9OX4tDo3znB14UfGBjlaU39a0A
         wj7dDnHRVTqTdWxcy/DhZn3MnrkIYtauKjHPdVaHiNvT27NF0zOICUv5GbTAR61uKt7h
         qVgQ==
X-Forwarded-Encrypted: i=1; AL+hErElWM/d+nuI3tXzVqByuEnsy1U1PL6I7E5iwRhNzskc7GmttsNQpbVrFA2FGvP9AcpXM3UMeLpt4G5h@vger.kernel.org
X-Gm-Message-State: APuU4Z95istSKjxsTYSDIf/gC0zvwlzP7R4gPq5YjgC6lS9qjl+pj+jq
	+4UUAcsIBY3GkbmtxeTCvVAV/LDhOW7iEOgkSw3QIBZpPU2QsDsB8xB8
X-Gm-Gg: AZFdTZcCCJx8AVBaIoJN2fk5puEMsNj28l6KUJ3sO93qviiDnA0QK1Vl4p4RjpAQc66
	BXoQXJ4p0eGxTZMa3G3SfSPshPShu2o+iMWs9GldxUvcPzV85vj4n0xi8iYOUuXbPJs/9wKWGEz
	+T+cLU8wYKaKIQZEdqaJXzbfwBamHTh8l7MMChCKGkmGMaV1DSdmyP3js1+pyNz0BzYBBp4Fxp0
	foeh4IWqpfdOK2soiB9qX9yYcI/HsZQfnzMi/OTHDS4ln5AlLJRY2h9rtQDkFflqy/OLujnuoO6
	uB4rfPkw/dTDf7JjTuRz63aWiqMUQdz4hwLhtPB7euKSesskIIH6xlR/7IjJ13c09xCUk4oB9at
	TWmZH8mlBbTjVc8Rl4osSs8U6IC2oPMykIoZqNrXpeEcN8h4bJrFLoOiKy7XKWULO3hF2Gp/n6W
	0GWebTQlbZxpynUvAtkOTY90k44ezvj9W+rvqaMfshHgejZR5ad1aMKBdkrV+IaDML1Hfgz9j2P
	BdHyBRgEM2crnx2MjqfT27dWCRJ03cnyUMQrosF882GPnUUMrF66DmDJKlH0N3lQIPLAglMh82+
	KL4GldREruReRku7JqCiVYazEg==
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb8881ae90mr541218935e9.32.1795827351797;
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b09bsm1328407645e9.4.2026.11.27.16.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 03:55:41 +0300
Message-ID: <20261128005541.873229-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
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

Jarkko Sakkinen <jarkko@kernel.org>:
> Work on this feature started in 2025 after reviewing David Howells'
> container object patch set [1], whose underlying mechanics made sense to

> [1] https://lore.kernel.org/all/155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk/
> [2] https://lwn.net/Articles/1102593/

You put wrong link in "[1]". This is not Howells' container patchset. This
is Howells' fsopen/fsmount patchset.

Link "[2]" seems to be wrong, too. It is not something "earlier", this is
very recent LWN article.

> While the patch set is manually written, the original motivation came
> from isolating LLM agents

LLM agents are too strong for Linux containers. They should be isolated
using VMs or using some Linux reimplementation, such as gVisor.

Bacik said that he tested his patchset in Anthropic. But I think it
was tested not for agents themselves, but for something else.

Anyway, I suggest to drop this phrase from your cover letter and think
about some other use case.

-- 
Askar Safin
