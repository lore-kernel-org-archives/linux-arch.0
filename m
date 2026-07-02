Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213E33F8CA;
	Thu,  2 Jul 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978486; cv=none; b=FL2U1zTpUj16QrUEhZyGZyKvOsfpY/fQjppMEMWhubR8zqoTtERIA1/k7WuhcNqi6spv0mrp0UaHZ4YnpoOgAf3E+p6ZpuRPFDOifC1qrz99n3j4ZmWbNUvjIL/QlAn8pqXbUGJZcnf1SQL5brrtLtCFLn4AJS6yCsdBjFVCZ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978486; c=relaxed/simple;
	bh=iq5IDacNqkK4D+r1dY9SZzQ4xGh6/ncHNeFC4F2FzI0=;
	h=From:To:Cc:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eHcbXCw/qkdmqtjLMTf88phXWgKyRg++LgmAgoLy1hsT4nKVr2TLXHWQQD5BoX9xAhRHPW4ToouvdiPdDtOaq87oznXgIuH7DyvpSXCc2myec6v270GSDZZe6eUmvZs8zQpekP8++zs3HjIBWfckxCv7ykbMQbUBJCSwH3mJ/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzaUkTUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzaUkTUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3356E1F000E9;
	Thu,  2 Jul 2026 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782978484;
	bh=zf+n+7geep32l3qdAzpVP4lARvoBFB3Fg31YxOXIA74=;
	h=From:To:Cc:Cc:In-Reply-To:References:Subject:Date;
	b=YzaUkTUh5WQGln1lfllhXS5QpzSmZ66alWnLiAUU193OK9d3IhkbFBCBDzsPj6Iw0
	 mpjz1z0N/cqqDE5tPAKFpbf42sC3DkRO/TIs9/EhU2TxklGewem0S8eGh5S8wHHuwy
	 n6O9jGsDz++TDwxvGi+z55qUps5Hm/Q+u5SfHcoH6RDbGQexshDX/i0oX5U3fTW3IK
	 bVN70lM3VXH/gxDUf4HAmT7Whnt0nkI8A9vkg1eOg5odpui2UPGjiE0YuJU2JHo2Yx
	 JY/Tj17o0iCOhoDsVx5FiLBD0loqdyMSsiVRT+gx+6kTzKeehaoFQl2wy6e2yr+FxP
	 NJFKseEJ3Yang==
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org
In-Reply-To: <20260531104947.6142-1-jkoolstra@xs4all.nl>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
Subject: Re: [PATCH] vfs: missing inode operation should return a
 consistent error code
Message-Id: <20260702-forensik-unfertig-korpulent-56f199eb061a@brauner>
Date: Thu, 02 Jul 2026 09:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iq5IDacNqkK4D+r1dY9SZzQ4xGh6/ncHNeFC4F2FzI0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5iW/6K6BdH/WYIy6ppPhDA2vm8/yqyms9CmIO1Zunt
 z47siO5o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLHfjEyND76IW21MetO8G+e
 bW9VN6Sxsz+QO+Mh8mxZrID6S7vTNQz/LD8uMP5t4WYxq26NQI9eoMrmjflF8rIVGuskda+sCfJ
 jBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 31 May 2026 12:49:46 +0200, Jori Koolstra wrote:
> vfs: missing inode operation should return a consistent error code

I've stuffed this on a separate branch. Let's see whether we see any
fallout.

---

Applied to the vfs-7.3.errno branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.errno branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.errno

[1/1] vfs: missing inode operation should return a consistent error code
      https://git.kernel.org/vfs/vfs/c/7028d60a643a

