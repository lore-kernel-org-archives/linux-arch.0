Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA337472D
	for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772060785; cv=pass; b=nkAzGDgk1LDqKsvdUzZwvzf9EnnDYV9//09pPravQBPaHCiCLSQY3TeGmihhnxJh960l7v5j5T2FehgyOzHbtIzqMBFvMdSORXkuVnwHJ1tPCTENnws/QOj4GPJF2L/s0hHWD2z3QNzA0/0wX+CXa9A8ckJ571Tt6zXTaZE81Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772060785; c=relaxed/simple;
	bh=W9lyoMsne8FGHHrjNNek3nZgafGdJjKzjxdCf0mXseM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LumJ8wewQR2wM4+xES+Q85mNCoBWqOjajs8lrQU8Q+yCn2MJ2Xo4TVzuP/Xu4XX0Ba2w6OR927R7vn8qEx24s05DouImCughtu217nmE0ZkUpG52bi9EyFc8tR5MVoJvrXcx7Ld6YzfZRcYBUZeAzIGYF9ldp5pqvNWscako2P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNKSYhCo; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNKSYhCo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a964077671so32895ad.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2026 15:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772060784; cv=none;
        d=google.com; s=arc-20240605;
        b=U9nBm5fazYILmZb+2kU2zoztRmZ+eh0iUIwpGustdxBT+f2vrYKp0gH8nfTOKdHdLi
         JKzGngpvsZIxNoEPz7DSKCi38ffluMCfEN4IT+8LzsKeDeQEU80ZdbA81kGzLvsgAJof
         UORDedhhYqIdjMWUglrO9VeseUVA2wDr7voWQdzHFNPPZBiPXVSto/n9AffLsr3kVkvA
         yJesTsWYpnrN/JOKOtwu3XPJQi3lU/OvwSDB6BbReQlWE1V9Qp6P0+9tVn1L/EUKPSl5
         0zFmnXwtccsSSpskbbVXeBJNxXfEILxGyxhw9+0VI2QmyFd0HxLgY5CJCORl8vHeKsrF
         ikTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OCcej487YgFKOPTEV46nBBjzZMXcrtqh5hw60mHgWDA=;
        fh=sKLu2xHg+BQeSW9W7mMAtLHzM9h7OhqAJi6wf9kUAs4=;
        b=Jekv38JLDf+O5BW8QYEzqoWkazZWG4BNcRVi8iWF8xfgnlg8DlnjhrWN6P5OMkS+Cv
         l1yYsGxyXNv+XJzFLWNFfwEIHp75oGrM+2xnCHAELfy8fpxeDzeMPEb9iq3VgeiSwgfq
         cD+IRMw4QEc3NQyj4mGQUYOZv+iduPgxLfR8t4Prjm+jKmI9DhLw2jJrRfwVatHgA2WE
         RTLEgLOktY+oTjqNnjILRUnX5W/iizu5dDo444wCet2dy/Fz/WCXXoGyhJfMvX4ChKWr
         F5lN5I6awDn6HihBCSnYaQOhHtMTluGmbO1dPhD/4OAmFBeZUJTfZSfzCon+/Rn1Kyjx
         VtLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772060784; x=1772665584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCcej487YgFKOPTEV46nBBjzZMXcrtqh5hw60mHgWDA=;
        b=mNKSYhCoR7SxKucy/Yh3pA3CvcKRSJO0SZQka7+dRnFeYEBHJhuxHRK5K4guqPK3Tx
         ZPNS/ge079zhRd4l2+Ax41E0gZViPZFcdnopLoBctPZXyjnmcoKC64Q5IrGiEhT7jue/
         V018R6YpDBlvhkbmNL8gKl81qVDrrODrA17hOUlFDLXrIR/JMyZgzt3SJvH1UZeTNbno
         ZV9cPKcqgPe9YpcWXn6iIN7VyzkOjBLt5oIIFVlTLluR99TidfG0fvtr6g4LdR9b4UZk
         9b+poH6zkvu8mPZgnusqpzAK7MsRYJfkR+EHAsgv6skPoYQ3UY6BDlAzAeHqT62HBC+l
         93LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772060784; x=1772665584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCcej487YgFKOPTEV46nBBjzZMXcrtqh5hw60mHgWDA=;
        b=cl083UVE57gasUvm35H6AMIFZ6z1VzWH49Wgh/tSgSuzRFcXgUrJqpBbB2Ugy54rU2
         QYBenjXghlxYFFgIVRIMf9vtFnDixXrSLJgHpdyONnJWnlm7TupW7JvUK4gKaxjV7Y+n
         B+r0d/yN71ZCeLfFRTs2tkBr8spT8EvQ6SYtX6itYdmsIupvsjW4Z3OXJ9AO5BoY3I5J
         fG2yqSY/avC6OkIKamHIgZhOMo+GMRssTCiCeEG/4VO0ISCwgOj6ZJNg7h8sD5NCqrns
         DDBQ5q095O9QyCvYgTxbtRjweTGgWR5T5WMmaK0X0OgrIdDil9EB8c/Rmq75WTqz1DJr
         i3fw==
X-Forwarded-Encrypted: i=1; AJvYcCVVdWGInbW0bG/uYr54d/Fd7hexzdtGbnHpDnEi+gQmwlnmfKgXS32zQxJCYGVurrx84ZzmPbory2xG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/e+fR/N3P9XND5MuUPs3BDdaQNXwZeU7DjyNxkWjAkouk5z9m
	AXaM9B3nGgMDe5YyTfZ4Ti1l3eqM6PMgdD9qV3kZr6X0LdByOm5u1mnp9W6uuLHe0lIf5dhsCnq
	HIxjW0x6jaYAZ1H732QhYyF7wjf2dAOrEhmcdeqIx
X-Gm-Gg: ATEYQzzv6NS61e+1LAEDZybPHXRr9gvGOLKzwFKkhmA+WJptj+iWvwe4/0MVEvhfJ+B
	WTWShvmgLbKrH3D5f9DnXqb8uVvAA3CtvKtkXFzVxDzcVbbtEHaXS7gqAxpEUCykZExeIqPPk6V
	Af9f9eqHxgyp1D7uATwhYuBqbJVpLMaitxiklsgKvKCCoMqCD3rnlj4+/V/UE5ekdD8x60PSC6y
	VGvm3pv/hG/J+m1y9hPKSuw6cy3LVqFp641KYSdCGGs8gvvTRKylmPWF7XaIqlGIJOoXgdQnyQ9
	w1uVA9ybHdrgLIrhpxmPD1Vj1WVHhQ3aobMEfg==
X-Received: by 2002:a17:902:ec83:b0:299:c368:6b1f with SMTP id
 d9443c01a7336-2adf77829e3mr890095ad.18.1772060783430; Wed, 25 Feb 2026
 15:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com> <b82a5ac3-33e9-4cbf-892a-f0c7f6fe0c20@kernel.org>
In-Reply-To: <b82a5ac3-33e9-4cbf-892a-f0c7f6fe0c20@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 25 Feb 2026 15:06:10 -0800
X-Gm-Features: AaiRm53L_V-Oqt0aKWGxGR-IMY7YR8csbAzuy6C894gHyFaSj1OZXeEBVl8_aWU
Message-ID: <CAC_TJvdgvyjyJsU4v6W+3tHKx_2e8UMJU3RT2HKLSngcC+yH3Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de, bp@alien8.de, 
	brauner@kernel.org, bsegall@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dietmar.eggemann@arm.com, ebiederm@xmission.com, 
	hpa@zytor.com, jakub.wartak@mailbox.org, jannh@google.com, 
	juri.lelli@redhat.com, khalid@kernel.org, liam.howlett@oracle.com, 
	linyongting@bytedance.com, lorenzo.stoakes@oracle.com, luto@kernel.org, 
	markhemm@googlemail.com, maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, 
	mhocko@suse.com, mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, 
	osalvador@suse.de, pcc@google.com, peterz@infradead.org, pfalcato@suse.de, 
	rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev, 
	surenb@google.com, tglx@linutronix.de, vasily.averin@linux.dev, 
	vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com, willy@infradead.org, x86@kernel.org, 
	xhao@linux.alibaba.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Isaac Manjarres <isaacmanjarres@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	android-mm <android-mm@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:40=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> > I believe that managing a pseudo-filesystem (msharefs) and mapping via
> > ioctl during process creation could introduce overhead that impacts
> > app startup latency. Ideally, child apps shouldn't be aware of this
> > sharing or need to manage the pseudo-filesystem on their end.
> All process must be aware of these special semantics.
>
> I'd assume that fork() would simply replicate mshare region into the
> fork'ed child process. So from that point of view, it's "transparent" as
> in "no special mshare() handling required after fork".

Hi David,

That's agood  point. If fork() simply replicates the mshare region, it
does achieve transparency in terms of setup.

I am still concerned about transparency in terms of observability.
Applications and sometimes inspect their own mappings (from
/proc/self/maps) to locate specific code or data regions for various
anti-tamper and obfuscation techniques. [2] If those mappings suddenly
point to an msharefs pseudo-file instead of the expected shared
library backing, it may break user-space assumptions and cause
compatibility issues.

Perhaps we could advertise the shared VMAs in the /proc/*/[s]maps
entries for the processes sharing these areas?

[2] https://lore.kernel.org/all/CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=3DdjCZG_=
bRVaCEMRmg@mail.gmail.com/

Thanks,
Kalesh


>
> --
> Cheers,
>
> David
