Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095C369D5A;
	Tue, 30 Jun 2026 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807036; cv=none; b=jw9mZJbF6ubPffBrZq9v8wRwlMIlEtCTAE3mtRMQsT1HMauMGoGicXruI+ba0LfGm4XFm0LreP/ATJNTbN6judFNIoNzxlk4AfXfv/wizlWAM2NSCMJrJvdZjDvFSXiJI4BPK31YT1JbpSTfKsQ5u44TZo4jt+NIhEg09cZ1BiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807036; c=relaxed/simple;
	bh=3Hu/AyHkz4mASSYxxFNDWErhvNFt0/dPFpeQCi6idbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OzeQPuz/maqyOVrB8Tm95GnqxtrBoaw7aM0KlGFhjhVcg97u3tVtOW8M9wx9EmXGDLVnT+1BVU/kzc98stOUU3Z8qTDtORcmAaF2k4UZ5QgJ0BQFFzNqXThMK2Wb06iHbhG51yz9KcO272hjA++r6O0LtBm8tHndqrTF+j7FYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M3UVh/O0; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M3UVh/O0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yM
	FvOab7JfjhFzPXVN7GoFjgSZR2kyk1cDhk7lmS3lE=; b=M3UVh/O0Jvp01mB0fW
	/lfDkszRjzteGlggE8Qi2E0kvUA1xbwb6dQaxNRDuykytA+uI37uu+wjD6maB1dB
	CVkY+mE/6fA0vJ1svCH7D2bcdKOziVea3Aa6eNm3gTk6T0OWGMpo9xAEWoCHluhk
	8ohzJ9Jl3kwWqWXb7caUIGZqY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX3su8eUNqwWWIGg--.46550S2;
	Tue, 30 Jun 2026 16:09:33 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: brauner@kernel.org
Cc: alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	chuck.lever@oracle.com,
	david@kernel.org,
	ebiederm@xmission.com,
	j.granados@samsung.com,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	keescook@chromium.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mcgrof@kernel.org,
	mjguzik@gmail.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for pre-exit before dumping
Date: Tue, 30 Jun 2026 16:09:32 +0800
Message-Id: <20260630080932.60881-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625-wappnen-drohbrief-wermutstropfen-c53538f01547@brauner>
References: <20260625-wappnen-drohbrief-wermutstropfen-c53538f01547@brauner>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX3su8eUNqwWWIGg--.46550S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4DWF4DKF1xAry7uw4rZrb_yoW8XFyfpF
	W5Ka93Ar4kGr17J3Z2ya1rXF1Fk3y5JF47XrW5W3y7u3Wkur1Svr48Kryag3ykCr1Ig3Wj
	qrnFv34Uu3sIqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR489tUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvx34A2pDeb2JZQAA3Y

Dear Christian,

On Thu, 25 Jun 2026 09:28:08 +0200 Christian Brauner <brauner@kernel.org> wrote:

> Nah, we're not doing a separate file for this. That makes no sense
> whatsoever. I've already explained this in the first mail. There are
> effectively three modes:
> 
> (1) dump to a file
> (2) spawn super-privileged usermode helper process connect coredumping
>     process and said helper via pipe
> (3) coredumping process connects to AF_UNIX socket
> 
> Parameterize (1) and (2) via a command line arguments. I strongly
> suspect you're using some AI tooling so it should be able to figure out
> how this was done in the past.
> 
> (3) can be extended by just introducing a new flag value for struct
>     coredump_req. That is also illustrated by previous work.
> 
> We're not spreading procfs files. It's terrible api design especially
> for security sensitive changes.


I am unsure whether the addition of a bit 9 for coredump_filter in version
v5 will be acceptable to everyone, as there are still many projects using
the coredump file and coredump pipe mechanisms. I found that coredump
files are used in elf_coredump_extra_notes_write, which makes it difficult
to distinguish between these two types and determine whether early release
of the files is possible without setting parameters. I am reluctant to add
another bit for this purpose, but it seems necessary. I am not sure if my
understanding is correct or if you have better suggestions, as I really do
not want to address only the coredump socket situation.

Thanks
Xin Zhao

