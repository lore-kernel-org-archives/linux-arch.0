Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8A2222B2;
	Thu, 19 Feb 2026 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488324; cv=pass; b=glFkp3Luc+2h3AV2OSEsDiR6u6/zzqpj7j1fz9x7U4m8x7uZkilVKhWRk5QxgAK+JU4zM3OYeUo30p3MI2wx+/yO6WrZNY43y51QRNVsRL27RoT5BTgjPdGteupxiQOcJF6CnPZONaY1FKlGHuO4Ry7qeAr1fRgN6zfr/+KCNE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488324; c=relaxed/simple;
	bh=mZ1okY8wh3/E7KclMIJhob/eOJu2zzwpAoIKVt+HodI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeH4LLYuRTSc58ogxW8YPNcf/ODMeg1ejviqbav6r8mcopQgrfnPTSzMjYbcmUaoER9ka9n7kPfa/gCKXHD0Eof1uLyzDmUDbhahuL6g54EH5QUomURJs5l5AOMrd+jASumGewFFYJePT1piZIGrBtC0doYIyfLoY1UCJNSiM48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=QevocWd9; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="QevocWd9"
ARC-Seal: i=1; a=rsa-sha256; t=1771488293; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ikjtOb3oX1EgHtdw2QAxqKYlVneQSwVpL0ucVwHo2BOn3HB/94myWhKMGQINXwdpOZK3npc4LWXT0YMSrQirMOoIz+sEXFjEdql88wfXp64KGkhIeNFuy7DLDj9rvmm2PWm5g2SNYv/JXH3pBME1YFe7gkhQJ6g4f2N7Z6ohgeM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771488293; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kYQ5NkddKGLVG7KXnc5tVWiA8oqeInGD+WTRnEtYdQ0=; 
	b=ca1PRjshbgl0kblWXlxZYjxLz4+EjGHd7r3vw5HoWB6wxiDrLsM3QC5vaKvKz7Clyg5R1kKeapY94Kb4FWBEyZbGPhhgYGjlOgmQXF9gU2aPZ0B26sB778xsKw693Dk8mkTwyV8ivBeFNMZc7EYzJJ10UxCBdOWLTdQ+Sh0piFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771488293;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=kYQ5NkddKGLVG7KXnc5tVWiA8oqeInGD+WTRnEtYdQ0=;
	b=QevocWd9wnFpbz6v8KCBM++Ys6nV8e156lzrioDP5AuZwNKDcNaawITAAg98QsGk
	Kb2uKNno6Tg11FVRfVCyTILiEQN1MdAM79iW7HpvdQ+22Qf+5kenHshvDOppuegxWjr
	7d1YgfTJOZuj6xEGdtMUB56dClW92AivaTYOIfLU=
Received: by mx.zohomail.com with SMTPS id 1771488291848192.88439580319414;
	Thu, 19 Feb 2026 00:04:51 -0800 (PST)
Date: Thu, 19 Feb 2026 08:04:42 +0000
From: Yao Zi <me@ziyao.cc>
To: guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	alex@ghiti.fr, leobras@redhat.com, djordje.todorovic@htecgroup.com,
	aleksa.paunovic@htecgroup.com, arnd@arndb.de, rabenda.cn@gmail.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH V3] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Message-ID: <aZbEGsqXSQzORQ__@pie>
References: <20260125063941.443777-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125063941.443777-1-guoren@kernel.org>
X-ZohoMailClient: External

On Sun, Jan 25, 2026 at 01:39:41AM -0500, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> The early version of XuanTie C910 core has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
> 
> So appending a fence w.o could immediately flush the store merge
> buffer and let other cores see the write result.
> 
> This will apply the WRITE_ONCE errata to handle the non-standard
> behavior via appending a fence w.o instruction for WRITE_ONCE().
> 
> This problem is only observed on the sg2042 hardware platform by
> running the lock_torture test program for half an hour. The problem
> was not found in the user space application, because interrupt can
> break the livelock.
> 
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

With the patch, I've run heavy multi-core compilation load on SG2042 for
more than 12 hours, and observed no stability issues.

Tested-by: Yao Zi <me@ziyao.cc>

Thanks,
Yao Zi
