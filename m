Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264665AbUIVLLm@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:51661 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264571AbUIVLLl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Sep 2004 07:11:41 -0400
Date: Wed, 22 Sep 2004 04:11:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: sem_is_locked()
Message-ID: <20040922111139.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

hch and some others (e.g. moi) trying to do vfs sweeps would very much
like to have a sem_is_locked() to assist them; by any chance could arch
maintainers help out with implementing this for various arches?

Thanks.


-- wli
