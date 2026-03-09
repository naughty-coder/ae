<?php /*if ($option['color']) { ?>
<div class="ocf-color" style="background-color: #<?php echo $value['color']; ?>;"></div>
<?php } ?>

<?php if ($option['image']) { ?>
<div class="ocf-image" style="background-image: url(<?php echo $value['image']; ?>);"></div>
<?php }*/ ?>

<?php if ($value['selected']) { ?>
  <li class="list-item">
    <input id="iv-<?php echo $value['id']; ?>" type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="<?php echo $value['params']; ?>" class="tf-check style-2 ocf-target" autocomplete="off" checked="checked" />

    <label for="iv-<?php echo $value['id']; ?>" id="v-<?php echo $value['id']; ?>" class="ocf-selected label" data-option-id="<?php echo $option['option_id']; ?>">
      <span><?php echo $value['name']; ?></span>
    </label>
  </li>
<?php } else if ($value['count']) { ?>
  <li class="list-item">
    <input id="iv-<?php echo $value['id']; ?>" type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="<?php echo $value['params']; ?>" class="tf-check style-2 ocf-target" autocomplete="off" />

    <label for="iv-<?php echo $value['id']; ?>" id="v-<?php echo $value['id']; ?>" class="label" data-option-id="<?php echo $option['option_id']; ?>">
      <span><?php echo $value['name']; ?></span><?php if ($show_counter) { ?><span class="count-wrap">[ <span class="count"><?php echo $value['count']; ?></span> ]</span><?php } ?>
    </label>
  </li>
<?php } else { ?>
<label id="v-<?php echo $value['id']; ?>" class="disabled" data-option-id="<?php echo $option['option_id']; ?>">
  <input type="<?php echo $option['type']; ?>" name="ocf[<?php echo $option['option_id']; ?>]" value="" disabled="disabled" class="ocf-target" autocomplete="off" />
  <?php echo $value['name']; ?>
  <?php if ($show_counter) { ?>
  <small class="badge">0</small>
  <?php } ?>
</label>
<?php } ?>