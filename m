Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466609;
	b=jLn8v9LLs1NiKwByJAZcrDZcdccft1JU5OiaejlUiyaubRlON8xHV5mTZ4IDUj6U1VNw
	 LlU+PhbDzvxfxrw073xfGmfOVKAPJ0Oj1wmmKdSagTq8RVCSLkXfqn9Brm0EqV0MG2ruk
	 2TYMaMlRbDGLlA6R2L2XKWpXdwRIfYOUtcM/PQd853CTk0urIv4aWa1Dlg6OlBtNwLY2a
	 lnoUNXcsqnzf8vv0nucCza5K1fV/wyDeEspKH+0TF4O8Pu4/iPdhFJiakiyPBYU07T2vl
	 4Mdnc4TFqpk+3xxYPUm5UR/PI65MeZPSz49Jlh+06LQCsZAE3duQUByTQiyhV8h5o8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
	b=Q02JVzRtCxKbmlGijmXgGfwC2kXekXWRGq8z5JYAKyQ/xjuq3UVn6TXImp0WF1OTs1i4
	 OEroXgNMT15vfyEEHkNjqrQc9Iy8Vd9D9EH+zOW2Y6acKzi5WYhFgxpOJM9IHT3IVcVDF
	 1pESQHUUaBuUOICn+GZAss+ft8eNy4nXw/QyuXUYWDU7F8wsO/OZcLUGGU2deM9CVSDow
	 2QhJa6ETabXeBQdW39qJA/jWyeZ8wR/b4yJcsBlendBq31PadVkJ+5zzb9/bXWrM+Fkm7
	 7AAsjytRQOTzCqnWFWroZ5uEhJlpxyifxld+fBKIWGCgQbSHZR2bEBSnwSXax+qzCAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAlQpn7V;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7C606A326
	for <linux-arch@vger.kernel.org>; Sat, 31 Oct 2026 17:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C7C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAlQpn7V
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdab938dc83so690998a12.3
        for <linux-arch@vger.kernel.org>; Sat, 31 Oct 2026 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466609; x=1794071409; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
        b=zAlQpn7V5Yxzz3a/EooOjbQS76Q6xQ0YpJEIcGp4YzdScOrPhhAvrUur4/FQHYJqRA
         8zfHghpz6jXKETFWCpI+22lxZ4tiU8Y1Wc2I1LGCzNcA48QIfHM0NthCxotitdxVloRD
         7jW5L//FxVzW4EuToHyaxOBM6p67ZQEXBbXMiVGM13bEtgPc/LRBcWVgFZo7OtjjXbae
         x38X4P6bQH9CmqpDSl/U0Gq7hPzrHgec0DsPUl+NFmdA/2pRimxjub456nrjYLulRtoc
         kY3kMmeFOtp3fe5XwkcAgy2f09rE2oqb/7WSkbZ5wd7smSeRqi0JaRIl0JBf3GPVA6ml
         lPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466609; x=1794071409;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S02zFKQTw98qLAlbNryreV97fiHHWFWx7ndQG3y57t8=;
        b=Cuoj82j7Hpv8LTre0XWB17rX1TcgmKf/EskDvoiEdryx/G2kMDwDj6v/36gkTe58w3
         Hwa6f064c/XoZcYYJMVS1dzreTS3PrP3awufGv4Ux2VRD2Pld3IKeFplXSifarJf7dqg
         y2drb77pB/bPgWLe/t4MvIiefAvTIGsuIq3llZVU94vQkRrtibPEUgUQOna1cVdW4lXR
         wZJ7FoAS5gWhKv9jRnwAhOrliwgX+wOP+OAFgYETzXtfbAk//46T2WThDbf32pOBXw5E
         ylg2+OGvpOOipMuW+1hHvAG8q+HIEWA8XrqlmjpMzS9oD3TEhnnw/1Dm9sBzFXTBK5R3
         oOvw==
X-Forwarded-Encrypted: i=1; AKwUvBzYxdmUWSIbqyK/hGKlgCe6DHLdX6lCbpXhxnb1zyOzOdc+BuJnfe7ovTU/vzJeXjE+cGSWypXResZA@vger.kernel.org
X-Gm-Message-State: AFq9FYIGHs3bmH8lXRqCVx5g0F4ywIdin1cT58m/nB045LBHDaX2M9lv
	keQVy+IoGhLwQZsD7mlCIwoHdlXt9a0VU3Z0DTEMBvTFnpIce58ghmDX
X-Gm-Gg: AYBFou15F3XiYj2Kbtkq7fAwgoC3vl4Vqs7hmO1q5AMX7D3hb0DtiSbAF5KD1crqi+5
	UtV2tbSTd+J7rnWN1eBBst4nAbSIEqkthFTR8QF67xwmfYDuUPIOm0PAeXeJsyaorK8VS4QJ4Cg
	JHyjQrN8OOj7eTiRT6Vz+fTB50ueCHIjR6i1DPi6VaI3tao+FhXunUVFp3l/SYsel0MQR/gFO8G
	E7k+PLpgGrNQKTc1U+/GdINe9WsgPqk7A5qR6aRpw8TZBcEiK2C3MGHVDxzaopg1Sf8XTI3nt+W
	1HFk9gw/ZSkBH5qdkjg+vwfAPMkPkT6u3g5mSLtiFrh202juD6aGVVlOB6wAFJmypohWDtrS+jQ
	iVirSFjMyENKv/rWBI3gjr2U2DyIhIGSdz5uAzwByzICZGuHiTHY9yohqjd9z3x5jMnBrBPQ4U2
	qRBLkzx4+XHMNCwSKgkL+4mKUnY/LndSbWn4pjLrvZjQ83tA+wvAPErYJsmyMY/R2h1+Tbs57cs
	mEn5Doz+UORE39XowALQNEj2bayRmxL2hNzJb9Cdi4U82Qw7IHRaDWFS+ZYcouzrJLtSLKglU+i
	kAcO6isecun1sIFRQYqbH0/lgrC3gaV6R1Hi75qxf1SkzB6fTdUR7POxLvkLEUNgd33M/4kEJGT
	qHkTgCKkrTZooMdr17c1iTmZ5ydq0kfRddQ==
X-Received: by 2002:a17:90b:1a8b:b0:3ac:9e76:aa76 with SMTP id 98e67ed59e1d1-3ae8970fd9dmr5106038a91.13.1793466608564;
        Sat, 31 Oct 2026 10:10:08 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm8093713a91.14.2026.10.31.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:10:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:10:07 +0000
Message-Id: <DMJ6UP7FV1X1.2E7I2ILPBS34P@gmail.com>
Cc: <ihor.solodrai@linux.dev>, <almagui@kernel.org>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <nathan@kernel.org>,
 <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <abuehaze@amazon.com>, <doebel@amazon.de>, <mpohlack@amazon.de>,
 <jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>, <mason@kernel.org>
Subject: Re: [PATCH bpf-next 11/13] bpf: keep module BTF until the vmlinux
 BTF is parsed
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <wanjay@amazon.com>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
In-Reply-To: <df56aa51cd704ab9a9b03d3574e6ab4c61d5e6d4cdddc17f4b0253f67cc077da@mail.kernel.org>
References: <20261031130959.23472-12-wanjay@amazon.com> <df56aa51cd704ab9a9b03d3574e6ab4c61d5e6d4cdddc17f4b0253f67cc077da@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 31, 2026 at 06:55 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +/* Undo btf_parse_kept_modules() of a round that is not published */
>> +static void btf_unparse_kept_modules(void)
>> +{
> [ ... ]
>> +		btf_mod->btf->data = NULL;	/* the kept copy */
>> +		btf_put(btf_mod->btf);
>> +		btf_mod->btf = NULL;
>> +	}
>> +}
[...]
> Can a module BTF that is rolled back by btf_unparse_kept_modules() still be
> reachable through btf_idr?

Yes. It's real. The NULL deref in the inline BTF is real too.

This is quite heavy. As you can see both bots poked plenty of holes.
Five of them are in the -ENOMEM rollback of patches 10 and 11:

  where                        what goes wrong
  ---------------------------  -------------------------------------------
  btf_get_fd_by_id()           takes a ref on a BTF that is rolled back
  btf_free_rcu()               reads btf_mod->data that rmmod freed
  btf_parse_kept_modules()     -ENOMEM in the inline BTF removes its file
  bpf_struct_ops_desc_init()   -ENOMEM of ->init() becomes -EINVAL
  btf_vmlinux_data()           -ENOMEM without btf_zst repeats forever

The rollback exists because vmalloc() gives up when the task is killed.

can we run the parse from a work item, schedule_work() + flush_work() ?
A kworker gets no signals, so -ENOMEM can be final, like without the
option. Every parse then ends in smp_store_release(&btf_vmlinux), and
btf_get_fd_by_id() sleeps on btf_vmlinux_lock until that.
Then no need for the retry, btf_unparse_kept_modules(), the 2nd call
of ->init(), etc.

See my other reply.

pw-bot: cr
